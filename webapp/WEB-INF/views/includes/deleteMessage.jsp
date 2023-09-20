<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal fade" id="delModal">
	<div class="modal-dialog" style="top: 100px">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">경고 메세지</h4>
			</div>
			<div class="modal-body">
				<h4>한 번 삭제하면 되돌릴 수 없습니다. 정말 삭제하시겠습니까?</h4>
			</div>
			<div class="modal-footer">
				<button id="modalDelBtn" type="button" class="btn btn-primary">삭제</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>