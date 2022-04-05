<?php $this->load->view('master/layout/header'); ?>
<?php $this->load->view('master/layout/topbar'); ?>
<?php $this->load->view('master/layout/sidebar'); ?>

<div class="content-wrapper">
    <section class="content-header">
        <h1>
            List Pengguna
        </h1>
        <ol class="breadcrumb">
            <li><a href="<?php echo base_url('main/Admin'); ?>"><i class="fa fa-dashboard"></i> Dashboard</a></li>
            <li class="">Management Data</li>
            <li class="active">Pengguna</li>
        </ol>
    </section>

    

    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <?php if (($this->session->flashdata('create')) or ($this->session->flashdata('update')) or ($this->session->flashdata('delete'))) : ?>

                    <div class="alert alert-success alert-dismissible">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                        <i class="icon fa fa-check"></i>
                        <?php echo $this->session->flashdata('create'); ?>
                        <?php echo $this->session->flashdata('update'); ?>
                        <?php echo $this->session->flashdata('delete'); ?>
                    </div>

                <?php elseif (($this->session->flashdata('failed'))) : ?>

                    <div class="alert alert-danger alert-dismissible">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                         <i class="icon fa fa-exclamation-triangle"></i>
                        <?php echo $this->session->flashdata('failed'); ?>
                    </div>

                <?php endif ?>

                <div class="box box-primary">
                    <div class="box-header">
                        <a href="" class="btn btn-sm btn-primary" data-toggle="modal" data-target="#create"><i class="fa fa-plus"></i>&nbsp; Tambah</a>
                    </div>

                    <div class="box-body">
                        <div class="table-responsive">
                            <div class="container-fluid">
                                <table id="example1" class="table table-bordered table-striped">
                                    <thead>
                                        <tr class="text-center">
                                            <th style="text-align: center;">No</th>
                                            <th style="text-align: center;">Foto</th>
                                            <th style="text-align: center;">Nama Pengguna</th>
                                            <th style="text-align: center;">Email</th>
                                            <th style="text-align: center;">Role</th>
                                            <th style="text-align: center;">Status</th>
                                            <th style="text-align: center;">Opsi</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php
                                        $no = 1;
                                        foreach ($user as $r) :
                                        ?>
                                            <tr>
                                                <th style="text-align: center;" width="50px"><?php echo $no++; ?></th>
                                                <th style="text-align: center;"> <center><img src="<?php echo base_url($r->file_gambar); ?>" class="img-circle" alt="User Image" width="30"></center></th>
                                                <th style="text-align: center;"><?php echo $r->nama_user; ?></th>
                                                <th style="text-align: center;"><?php echo $r->email_user; ?></th>
                                                <th style="text-align: center;"><?php echo $r->name_role; ?></th>
                                                <th style="text-align: center;">
                                                    <?php if ($r->status_active == '1') : ?>
                                                        <span class="label label-success">Active</span>
                                                    <?php else : ?>
                                                        <span class="label label-danger">Non Active</span>
                                                    <?php endif ?>
                                                </th>
                                                <th style="text-align: center;" width="350px">
                                                    <?php if ($r->id_role == '1') : ?>
                                                    -
                                                    <?php else : ?>
                                                        <?php if ($r->status_active == '1') : ?>
                                                            <a href="<?php echo base_url('master/User/update_status/') . $r->id_user . '/' . $r->status_active ?>" class="btn btn-sm btn-danger is-non-active"><i class="fa fa-times"></i>&nbsp; Non Active</a>
                                                        <?php else : ?>
                                                            <a href="<?php echo base_url('master/User/update_status/') . $r->id_user . '/' . $r->status_active ?>" class="btn btn-sm btn-success is-active"><i class="fa fa-check"></i>&nbsp; Active</a>
                                                        <?php endif ?>
                                                        <a href="" class="btn btn-sm btn-warning" data-toggle="modal" data-target="#update<?php echo $r->id_user; ?>"><i class="fa fa-edit"></i>&nbsp; Edit</a>
                                                        <a href="" class="btn btn-sm btn-primary" data-toggle="modal" data-target="#update_password<?php echo $r->id_user; ?>"><i class="fa fa-key"></i>&nbsp; Edit Password</a>
                                                        <a href="<?php echo base_url('master/User/delete/') . $r->id_user; ?>" class="btn btn-sm btn-danger delete"><i class="fa fa-trash"></i>&nbsp; Hapus</a>
                                                    <?php endif ?>
                                                </th>
                                            </tr>
                                        <?php
                                        endforeach;
                                        ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<!-- Modal Create -->
<div class="modal fade" id="create" tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
    <form method="post" action="<?php echo base_url('master/User/create'); ?>" enctype="multipart/form-data">
        <div class="modal-dialog modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><span class="fa fa-close"></span></span></button>
                    <h3 class="modal-title font-weight-bold">Tambah <?php echo $title ?></h3>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="id_user" name="id_user" value="<?php echo $code ?>">
                    <div class="form-group">
                        <label for="nama_user" class="col-form-label">Nama Pengguna</label>
                        <input type="text" id="nama_user" name="nama_user" class="form-control" placeholder="Example : Lexianus Razoric" required>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Email</label>
                        <input type="email" id="email_user" name="email_user" class="form-control" placeholder="Example : lexi@example.com" required>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Role</label>
                        <select id="id_role" name="id_role" class="form-control">
                            <?php foreach ($role as $_role) : ?>
                                <option value="<?php echo $_role->id_role; ?>"><?php echo $_role->name_role; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Foto Profile</label>
                        <input type="file" id="image" name="image" class="dropify" data-height="150" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Kembali</button>
                    <button type="submit" class="btn btn-success">Simpan</button>
                </div>
            </div>
        </div>
    </form>
</div>
<!-- End of Modal Create -->

<!-- Modal Update -->
<?php foreach ($user as $r) : ?>
    <div class="modal fade" id="update<?php echo $r->id_user; ?>" tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
        <form method="post" action="<?php echo base_url('master/User/update'); ?>">
            <div class="modal-dialog modal-dialog-scrollable" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><span class="fa fa-close"></span></span></button>
                        <h3 class="modal-title font-weight-bold">Edit <?php echo $title ?></h3>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="control-label">ID Pengguna</label>
                            <input type="text" id="id_user" name="id_user" class="form-control" value="<?php echo $r->id_user; ?>" readonly>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Nama Pengguna</label>
                            <input type="text" id="nama_user" name="nama_user" class="form-control" placeholder="Example : Lexianus Razoric" value="<?php echo $r->nama_user; ?>" required>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Email</label>
                            <input type="text" id="email" name="email_user" class="form-control" placeholder="Example : lexi@example.com" value="<?php echo $r->email_user; ?>" required>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Role</label>
                            <select id="id_role" name="id_role" class="form-control">
                                <?php foreach ($role as $_role) : ?>
                                    <?php if ($_role->id_role == $r->id_role) : ?>
                                        <option value="<?php echo $_role->id_role ?>" selected><?php echo $_role->name_role; ?></option>
                                    <?php else : ?>
                                        <option value="<?php echo $_role->id_role ?>"><?php echo $_role->name_role; ?></option>
                                    <?php endif ?>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Kembali</button>
                        <button type="submit" class="btn btn-success">Simpan</button>
                    </div>
                    
                </div>
            </div>
        </form>
    </div>
<?php endforeach; ?>
<!-- End of Modal Update -->

<!-- Modal Update Password -->
<?php foreach ($user as $r) : ?>
    <div class="modal fade" id="update_password<?php echo $r->id_user; ?>" tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
        <form method="post" action="<?php echo base_url('master/User/update_password'); ?>">
            <div class="modal-dialog modal-dialog-scrollable" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title font-weight-bold">Edit Password <?php echo $title ?></h5>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="id_user" name="id_user" value="<?php echo $r->id_user; ?>">
                        <div class="form-group">
                            <label class="control-label">Password</label>
                            <input type="password" id="new_password" name="new_password" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label class="control-label">Repeat Password</label>
                            <input type="password" id="repeat_password" name="repeat_password" class="form-control" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Kembali</button>
                        <button type="submit" class="btn btn-success">Simpan</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
<?php endforeach; ?>
<!-- End of Modal Update Password -->
  
<?php $this->load->view('master/layout/footer'); ?>