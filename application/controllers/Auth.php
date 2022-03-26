<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Auth extends CI_Controller
{
    function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
        if ($this->session->userdata('email')) {
            if ($this->session->userdata('id_role') == 1) {
                redirect('master/DashboardSuperAdministrator');
            } else if ($this->session->userdata('id_role') == 2) {
                redirect('master/DashboardAdministrator');
            } else if ($this->session->userdata('id_role') == 3) {
                redirect('master/DashboardOwner');
            } else {
                redirect('master/DashboardCashier');
            }
        }

        $this->form_validation->set_rules('email', 'Email', 'trim|required', [
            'required' => 'Email harap diisi!'
        ]);

        $this->form_validation->set_rules('password', 'Password', 'trim|required', [
            'required' => 'Password harap diisi!'
        ]);

        if ($this->form_validation->run() == false) {
            $data['title'] = 'Login';

            $this->load->view('auth/login', $data);
        } else {
            $this->login();
        }
    }

    private function login()
    {
        $email = $this->input->post('email');
        $password = $this->input->post('password');

        $user = $this->db->get_where('tbl_user', ['email_user LIKE binary' => $email])->row_array();

        if ($user) {
            $login_user = $this->db->get_where('tbl_user', array('email_user' => $email))->row();

            if ($user['status_active'] == '1') {

                if (password_verify($password, $login_user->password_user)) {
                    $data = array(
                        'id_user' => $login_user->id_user,
                        'status' => 'Login'
                    );

                    $this->LoginModels->input($data, 'log_history');
                    $last_insert_id = $this->db->insert_id();

                    $data_session = [
                        'id_user' => $login_user->id_user,
                        'email_user' => $login_user->email_user,
                        'password_user' => $login_user->password_user,
                        'id_role' => $login_user->id_role,
                        'id_log' => $last_insert_id
                    ];

                    $this->session->set_userdata($data_session);

                    $this->db->update('tbl_user', array('login_attempt' => '0'));

                    if ($this->session->userdata('id_role') == 1) {
                        redirect('master/DashboardSuperAdministrator');
                    } else if ($this->session->userdata('id_role') == 2) {
                        redirect('master/DashboardAdministrator');
                    } else if ($this->session->userdata('id_role') == 3) {
                        redirect('master/DashboardOwner');
                    } else {
                        redirect('master/DashboardCashier');
                    }
                } else {
                    if ($login_user->login_attempt >= 3) {
                        $data = array(
                            'status_active' => '0'
                        );

                        $where = array(
                            'id_user' => $login_user->id_user
                        );

                        $this->LoginModels->update($where, $data, 'tbl_user');
                        $this->session->set_flashdata('message', '<div class="alert alert-danger" role="alert">Login gagal! Akun Anda terkunci, silahkan hubungi Admin untuk mengaktifkannya kembali</div>');
                        redirect($_SERVER['HTTP_REFERER']);
                    } else {
                        $data = array(
                            'login_attempt' => $login_user->login_attempt + 1
                        );

                        $where = array(
                            'id_user' => $login_user->id_user
                        );

                        $this->LoginModels->update($where, $data, 'tbl_user');
                        $this->session->set_flashdata('message', '<div class="alert alert-danger" role="alert">Kata Sandi Salah</div>');
                        redirect($_SERVER['HTTP_REFERER']);
                    }
                }
            } else {
                $this->session->set_flashdata('message', '<div class="alert alert-danger" role="alert">Akun Anda tidak aktif!!</div>');
                redirect($_SERVER['HTTP_REFERER']);
            }
        } else {
            $this->session->set_flashdata('message', '<div class="alert alert-danger" role="alert">Akun Anda tidak terdaftar!!</div>');
            redirect($_SERVER['HTTP_REFERER']);
        }
    }

    public function logout()
    {
        $id_user = $this->session->userdata('id_user');
        $id_log = $this->session->userdata('id_log');

        $data = array(
            'id_user' => $id_user,
            'status_active' => 'Logout'
        );

        $where = array(
            'id_log' => $id_log
        );

        $this->LoginModels->update($where, $data, 'log_history');

        $this->session->sess_destroy();
        redirect('Auth');
    }
}