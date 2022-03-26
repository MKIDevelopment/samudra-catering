<?php

function is_logged_in()
{
    $ci = get_instance();

    if (!$ci->session->userdata('email_user')) {
        redirect('Auth');
    } 
    // else {
    //     $menu = $ci->uri->segment(2);

    //     $where = array('file_name' => $menu);

    //     $queryMenu = $ci->db->get_where('sub_menu', $where)->row();
    //     $menu_id = $queryMenu->menu_id;

    //     $userAccess = $ci->db->get_where('user_access', [
    //         'role_id' => $ci->session->userdata('role_id'),
    //         'menu_id' => $menu_id
    //     ]);

    //     if ($userAccess->num_rows() < 1) {
    //         redirect('Blocked');
    //     }
    // }
}