<?php
$where = array(
    'id_role' => $this->session->userdata('id_role'),
);

$session = $this->db->get_where('tbl_user', $where)->row();
?>

<div class="wrapper">

    <header class="main-header">
        <a href="" class="logo">
            <span class="logo-lg"><b>Samudra</b>Catering</span>
        </a>

        <nav class="navbar navbar-static-top">
            <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
                <span class="sr-only">Toggle navigation</span>
            </a>

            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <li class="dropdown user user-menu">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <img src="<?php echo base_url(); ?><?php echo $session->file_gambar; ?>" class="user-image" alt="User Image">
                            <span class="hidden-xs"><?php echo $session->nama_user; ?></span>
                        </a>
                        <ul class="dropdown-menu">

                            <li class="user-header">
                                <img src="<?php echo base_url(); ?><?php echo $session->file_gambar; ?>" class="img-circle" alt="User Image">

                                <p>
                                    <?php echo $session->nama_user; ?>
                                    <small><?php echo $session->email_user; ?></small>
                                </p>
                            </li>

                            <li class="user-footer">
                                <div class="pull-right">
                                    <a href="<?php echo base_url('Auth/logout') ?>" class="btn btn-default btn-flat logout">Sign out</a>
                                </div>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </nav>
    </header>