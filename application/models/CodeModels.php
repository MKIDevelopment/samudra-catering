<?php
defined('BASEPATH') or exit('No direct script access allowed');

class CodeModels extends CI_Model
{
    function create_code_user(){
        $this->db->select('RIGHT(tbl_user.id_user,5) as kode', FALSE);
        $this->db->order_by('id_user', 'DESC');
        $this->db->limit(1);
        $query = $this->db->get('tbl_user');   
        if ($query->num_rows() <> 0) {

            $data = $query->row();
            $kode = intval($data->kode) + 1;
        } else {
            $kode = 1;
        }
        $kodemax = str_pad($kode, 5, "0", STR_PAD_LEFT);
        $kodejadi = "P" . $kodemax;
        return $kodejadi;
    }
}