<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class User extends CI_Controller {
	public function __construct()
    {
        parent::__construct();

        $this->load->model('DataModels');
        $this->load->model('CodeModels');

        is_logged_in();
    }

	public function index()
	{
		$data['title'] = 'Manajemen Pengguna';
        $data['code'] = $this->CodeModels->create_code_user();

        $where_user = array('tbl_user.data_status' => '1');
        $data['user'] = $this->DataModels->get_where_user($where_user, 'tbl_user');

		$data['role'] = $this->DataModels->get_where_role('tbl_role');

		$this->load->view('master/user/index', $data); 
	}

	public function create()
    {
        $id_user = $this->input->post('id_user');
        $id_role = $this->input->post('id_role');
        
        if ($id_role == "2") {
            $id_toko = Null;
        }
        else{
            $id_toko = $this->input->post('id_toko');
        }

        $nama_user = htmlspecialchars($this->input->post('nama_user'));
        $email_user = htmlspecialchars($this->input->post('email_user'));
        $password_user = password_hash('123456789', PASSWORD_DEFAULT);
        $file_gambar = $_FILES['image']['name'];

        $cekdata = $this->DataModels->check_data("tbl_user",['email_user' => $email_user, 'data_status' => '1'])->num_rows();

        if ($cekdata == 0) {
            if ($file_gambar) {
                $config['file_name'] = $id_user;
                $config['allowed_types'] = 'jpg|jpeg|png';
                $config['max_size']     = 5120;
                $config['upload_path'] = './assets/images/profile/';        

                $this->load->library('upload', $config);

                if ($this->upload->do_upload('image')) {
                    $image = $this->upload->data();

                    $config['image_library'] = 'gd2';
                    $config['source_image'] = './assets/images/profile/' . $image['file_name'];
                    $config['create_thumb'] = FALSE;
                    $config['maintain_ratio'] = FALSE;
                    $config['quality'] = '100%';
                    $config['width'] = 512;
                    $config['height'] = 512;
                    $config['new_image'] = './assets/images/profile/' . $image['file_name'];
                    $this->load->library('image_lib', $config);
                    $this->image_lib->resize();

                    $file_gambar = $image['file_name'];

                    $data = array(
                        'id_user' => $id_user,
                        'id_role' => $id_role,
                        'nama_user' => $nama_user,
                        'email_user' => $email_user,
                        'password_user' => $password_user,
                        'status_active' => '1',
                        'file_gambar' => "assets/images/profile/" . $file_gambar
                    );

                    $this->DataModels->create($data, 'tbl_user');
                    $this->session->set_flashdata('create', 'Data Pengguna berhasil ditambahkan!');
                    redirect($_SERVER['HTTP_REFERER']);
                } else {
                    $msg_errornya = $this->upload->display_errors();
                    $this->session->set_flashdata('failed', $msg_errornya);
                    redirect($_SERVER['HTTP_REFERER']);
                }
            }
        }
        else{
            $this->session->set_flashdata('failed', 'email_user Sudah Terdaftar!');
            redirect($_SERVER['HTTP_REFERER']);
        }   
    }

	public function update()
	{
        // Input Data from View
        $id_user = $this->input->post('id_user');
        $nama_user = htmlspecialchars($this->input->post('nama_user'));
        $email_user = htmlspecialchars($this->input->post('email_user'));
        $id_role = $this->input->post('id_role');

        $where = array(
            'id_user' => $id_user
        );

        $data = array(
            'email_user' => $email_user,
            'nama_user' => $nama_user,
            'id_role' => $id_role
        );

        $query = $this->DataModels->update($where, $data, 'tbl_user');

        $this->session->set_flashdata('update', 'Data User berhasil diperbarui!');
        redirect($_SERVER['HTTP_REFERER']);
	}

	public function update_password()
    {
        $id_user = $this->input->post('id_user');
        $new_password = $this->input->post('new_password');
        $repeat_password = $this->input->post('repeat_password');

        if ($new_password == $repeat_password) {
            $data = array(
                'password_user' => password_hash($new_password, PASSWORD_DEFAULT)
            );

            $test = $this->DataModels->update(array('id_user' => $id_user), $data, 'tbl_user');

            $this->session->set_flashdata('update', 'Password Pengguna berhasil diperbarui');
            redirect($_SERVER['HTTP_REFERER']);
        } else {
            $this->session->set_flashdata('failed', 'Password Pengguna gagal diperbarui!');
            redirect($_SERVER['HTTP_REFERER']);
        }
    }

	public function update_status($id_user, $status_active)
    {
        if ($status_active == '0') {
            $status_active = '1';
        } else {
            $status_active = '0';
        }

        $where = array(
            'id_user' => $id_user
        );

        $data = array(
            'status_active' => $status_active
        );

        $query = $this->DataModels->update($where, $data, 'tbl_user');
        $this->session->set_flashdata('update', 'Status Pengguna berhasil diperbarui!');
        redirect($_SERVER['HTTP_REFERER']);
    }

	public function delete($id_user)
	{
		$where = array('id_user' => $id_user);
        
        $data = array('data_status' => '0');

        $this->DataModels->update($where, $data, 'tbl_user');
        $this->session->set_flashdata('delete', 'Data Pengguna berhasil dihapus!');
        redirect($_SERVER['HTTP_REFERER']);
	}
}