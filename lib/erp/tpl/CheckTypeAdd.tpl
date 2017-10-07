<script>
	var setting={data:{simpleData:{enable:true,idKey:'id',pIdKey:'pid'}},view:{dblClickExpand:dblClickExpand},callback:{onClick:onClick}};
	var setting1={data:{simpleData:{enable:true,idKey:'id',pIdKey:'pid'}},view:{dblClickExpand:false},callback:{onClick:onClick1}};
	var nodes=<?php echo $tree; ?>;
	var nodes1=<?php echo $tree1; ?>;
	function onClick(e, treeId, node) {
		Redirect('?m=System&a=CheckTypeList&id=' + node.id);
	}
	function onClick1(e, treeId, node) {
		if(node.level>0 && node.type==2){
			$('#parent').val(node.name);
			$('#pid').val(node.id);
		}
		else{
			$('#parent').val('');
			$('#pid').val('');
		}
	}
	function dblClickExpand(treeId, treeNode) {
		return treeNode.level > 0;
	}

	$(function(){
		$.fn.zTree.init($("#tree"), setting, nodes);
		$.fn.zTree.init($("#tree1"), setting1, nodes1);

		$('#ok').click(function(){
			$.post('?m=System&a=OnCheckTypeAdd', {pid:$('#pid').val(),name:$('#name').val(),score:$('#score').val()}, function (ret){if(ret.code==1)layer.msg('增加成功', 1, function(){window.history.back();});else layer.msg(ret.msg, 1);}, 'json');
		});
	});
</script>

<div class="toolbar">
	<div class="tool clear"><span class="cap">增加项目</span></div>
</div>
<div class="sideorg">
	<ul id="tree" class="ztree"></ul>
</div>
<div class="panelgroup">
	<table class="ti">
		<tr>
			<td class="k">上级项目</td>
			<td class="v"><input type="text" id="parent" class="r" readonly onclick="TreeBox(this)" value="<?php echo $parent; ?>" /><div id="parentbox" class="treebox"><ul id="tree1" class="ztree"></ul></div><input type="hidden" id="pid" value="<?php echo $pid; ?>" /></td>
			<td class="k">分类项目</td>
			<td class="v"><input type="text" id="name" class="r"/></td>
			<td class="k">默认评分</td>
			<td class="v"><input type="text" id="score" class="r" value="0"/></td>
			<td class="k"></td>
			<td class="v"></td>
		</tr>
	</table>
	<div class="bpan"><input type="button" id="ok" class="bok" value="确定" /><input type="button" class="bback" value="返回" /></div>
</div>