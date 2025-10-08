<!-- BEGIN: main -->
<!-- BEGIN: list -->
{foreach $LIST as $DEPARTMENT => $SUPS}
<div class="table-responsive">
    <table class="table table-striped table-bordered list" data-url="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&amp;{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&amp;{$smarty.const.NV_OP_VARIABLE}={$OP}">
        <thead class="bg-primary">
            <tr>
                <th colspan="2" class="text-center">{$LANG->getModule('full_name')}</th>
                <th class="text-nowrap text-center" style="width: 1%;">{$LANG->getGlobal('phonenumber')}</th>
                <th class="text-nowrap text-center" style="width: 1%;">{$LANG->getGlobal('email')}</th>
                <th class="text-nowrap text-center" style="width: 1%;">{$LANG->getModule('active')}</th>
                <th class="text-nowrap text-center" style="width: 1%;">{$LANG->getGlobal('actions')}</th>
            </tr>
        </thead>
        <!-- BEGIN: department -->
        <tbody>
            <tr>
                <td colspan="6" class="bg-department">
                    <i class="fa fa-folder-open"></i>
                    {if !empty($DEPARTMENT)}
                    <!-- BEGIN: href -->
                    <a href="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&amp;{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&amp;{$smarty.const.NV_OP_VARIABLE}=row&amp;id={$DEPARTMENT}">
                    {/if}<!-- END: href --><strong>{$DEPARTMENTS.$DEPARTMENT.full_name}</strong>
                    {if !empty($DEPARTMENT)}<!-- BEGIN: href2 -->
                    </a><!-- END: href2 -->
                    {/if}
                </td>
            </tr>
            {foreach $SUPS as $SUPPORTER}
            <!-- BEGIN: loop -->
            <tr class="item" data-id="{$SUPPORTER.id}">
                <td class="text-nowrap align-middle" style="width: 80px;">
                    <select class="form-control supporter_cweight" data-default="{$SUPPORTER.weight}">
                        {for $I = 1 to $DEPARTMENTS.$DEPARTMENT.supporters}
                        <!-- BEGIN: weight -->
                        <option value="{$I}" {if $SUPPORTER.weight == $I}selected{/if}>{$I}</option>
                        <!-- END: weight -->
                        {/for}
                    </select>
                </td>
                <td class="align-middle">{$SUPPORTER.full_name}</td>
                <td class="text-nowrap align-middle">{$SUPPORTER.phone}</td>
                <td class="text-nowrap align-middle">{$SUPPORTER.email}</td>
                <td class="text-nowrap text-center align-middle">
                    <input type="checkbox" class="supporter_act" value="1" {if !empty($SUPPORTER.act)}checked{/if}>
                </td>
                <td class="text-nowrap text-center align-middle">
                    <button type="button" class="btn btn-sm btn-secondary supporter_edit" title="{$LANG->getGlobal('edit')}"><i class="fa fa-pencil"></i></button>
                    <button type="button" class="btn btn-sm btn-secondary supporter_del" title="{$LANG->getGlobal('delete')}"><i class="fa fa-trash text-danger"></i></button>
                </td>
            </tr>
            <!-- END: loop -->
            {/foreach}
        </tbody>
        <!-- END: department -->
    </table>
</div>
{/foreach}
<!-- END: list -->
<div class="text-center">
<button type="button" data-url="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&amp;{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&amp;{$smarty.const.NV_OP_VARIABLE}={$OP}" class="btn btn-primary supporter_add{if empty($SUPPORTERS)} auto{/if}">{$LANG->getModule('supporter_add')}</button>
</div>
<!-- Add_Supporter_Modal -->
<div class="modal fade" id="content" data-backdrop="static" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body"></div>
        </div>
    </div>
</div>
<!-- END: main -->

{* <!-- BEGIN: content -->
<form action="{$FORM_ACTION}" method="post" class="form-horizontal supporter_content">
    <div class="form-group">
        <label class="col-sm-8 control-label">{$LANG->getModule('department_parent')}</label>
        <div class="col-sm-16">
            <select class="form-control" name="departmentid">
                <option value="0">{$LANG->getModule('department_empty')}</option>
                <!-- BEGIN: department -->
                <option value="{$DEPARTMENT.id}" {$DEPARTMENT.sel}>{$DEPARTMENT.full_name}</option>
                <!-- END: department -->
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-8 control-label">{$LANG->getModule('full_name')}</label>
        <div class="col-sm-16">
            <input type="text" class="form-control required" name="full_name" value="{$SUPPORTER.full_name}" maxlength="250" />
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-8 control-label">{$LANG->getModule('supporter_avatar')}</label>
        <div class="col-sm-16 field">
            <div class="input-group">
                <input class="form-control" type="text" name="image" value="{$SUPPORTER.image}" id="selectfile" />
                <span class="input-group-btn">
                    <button class="btn btn-secondary selectfile" data-toggle="selectfile" data-target="selectfile" data-path="{$MODULE_UPLOAD}" data-type="image" type="button">
                        <i class="fa fa-folder-open-o fa-fix"></i>
                    </button>
                    <button class="btn btn-secondary help-show" type="button">
                        <i class="fa fa-question fa-fix"></i>
                    </button>
                </span>
            </div>
            <div class="help-block" style="display: none;">{$LANG->getModule('supporter_avatar_note')}</div>
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-8 control-label">{$LANG->getGlobal('phonenumber')}</label>
        <div class="col-sm-16 field">
            <div class="input-group">
                <input type="text" class="form-control required" name="phone" value="{$SUPPORTER.phone}" maxlength="250" />
                <span class="input-group-btn">
                    <button class="btn btn-secondary help-show" type="button">
                        <i class="fa fa-question fa-fix"></i>
                    </button>
                </span>
            </div>
            <div class="help-block" style="display: none;">{$LANG->getGlobal('phone_note_content')}</div>
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-8 control-label">{$LANG->getGlobal('email')}</label>
        <div class="col-sm-16">
            <input type="text" class="form-control" name="email" value="{$SUPPORTER.email}" maxlength="100" />
        </div>
    </div>

    <div class="form-group">
        <label class="col-xs-24">{$LANG->getModule('otherContacts')}</label>
        <div class="col-xs-24 strs">
            <!-- BEGIN: other -->
            <div class="str" style="display:flex">
                <div class="row" style="flex-grow:1">
                    <div class="col-xs-10">
                        <input type="text" class="form-control" name="other_name[]" value="{$OTHER.name}" placeholder="{$LANG->getModule('otherVar')}" maxlength="250" />
                    </div>
                    <div class="col-xs-14">
                        <input type="text" class="form-control" name="other_value[]" value="{$OTHER.value}" placeholder="{$LANG->getModule('otherVal')}" maxlength="250" />
                    </div>
                </div>
                <div class="text-nowrap" style="margin-left:10px">
                    <button class="btn btn-secondary str_add" type="button">
                        <i class="fa fa-plus fa-fix"></i>
                    </button>
                    <button class="btn btn-secondary str_del" type="button">
                        <i class="fa fa-times fa-fix"></i>
                    </button>
                </div>
            </div>
            <!-- END: other -->
        </div>
    </div>

    <div class="text-right">
        <input type="hidden" name="fc" value="content">
        <input type="hidden" name="id" value="{$SUPPORTER.id}">
        <input type="hidden" name="save" value="1">
        <button type="submit" class="btn btn-primary">{$LANG->getModule('save')}</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">{$LANG->getGlobal('close')}</button>
    </div>
</form>
<!-- END: content --> *}
