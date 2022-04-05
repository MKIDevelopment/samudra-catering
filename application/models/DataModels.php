<?php
defined('BASEPATH') or exit('No direct script access allowed');

class DataModels extends CI_Model
{
    function get_one_table($table)
    {
        $query = $this->db->get_where($table);
        return $query->result();
    }

    function get_where_table($where, $table)
    {
        $query = $this->db->get_where($table, $where);
        return $query->result();
    }

    function create($data, $table)
    {
        $this->db->insert($table, $data);
    }

    function update($where, $data, $table)
    {
        $this->db->where($where);
        $this->db->update($table, $data);
    }

    function delete($where, $table)
    {
        $this->db->where($where);
        $this->db->delete($table);
    }

    function check_data($table, $where)
    {
        return $this->db->get_where($table, $where);
    }

    function get_where_user($where, $table)
    {
        $this->db->select('tbl_user.*, tbl_role.*');
        $this->db->join('tbl_role', 'tbl_user.id_role = tbl_role.id_role');
        $this->db->order_by('tbl_user.id_role', 'ASC');

        $query = $this->db->get_where($table, $where);
        return $query->result();
    }

    function get_where_role()
    {
        $SQL = "SELECT * FROM tbl_role WHERE data_status='1' AND id_role!='1'";
        return $this->db->query($SQL)->result();
    }
}