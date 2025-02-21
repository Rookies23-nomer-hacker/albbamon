<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>������Ȳ</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            background-color: #ffffff;
            padding: 20px;
        }
        .container {
            width: 900px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border: 2px solid #ff6600;
        }
        .header {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }
        .info {
            font-size: 14px;
            color: #666;
            margin-bottom: 20px;
        }
        .status-container {
            display: flex;
            justify-content: space-around;
            padding: 10px;
            background: #f8f8f8;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .status-box {
            text-align: center;
        }
        .status-number.total {
            font-size: 24px;
            font-weight: bold;
            color: #ff6600;
        }
        .status-number {
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }
        .status-label {
            font-size: 14px;
            color: #666;
        }
        .tab-menu {
            display: flex;
            border-bottom: 2px solid #ddd;
            margin-bottom: 20px;
        }
        .tab {
            flex: 1;
            text-align: center;
            padding: 10px;
            cursor: pointer;
            font-weight: bold;
        }
        .tab.active {
            border-bottom: 2px solid #ff6600;
            color: #ff6600;
        }
        .job-list {
            margin-top: 20px;
        }
        .job-item {
            padding: 15px;
            border-bottom: 1px solid #ddd;
        }
        .job-title {
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }
        .job-meta {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
        .actions {
            margin-top: 10px;
            display: flex;
            justify-content: space-between;
        }
        .btn {
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            font-size: 12px;
            cursor: pointer;
        }
        .btn-orange {
            background-color: #ff6600;
            color: white;
        }
        .btn-gray {
            background-color: #ddd;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">������Ȳ</div>
        <div class="info">�ֱ� 1�� �̳��� ���������� Ȯ���� �� �ֽ��ϴ�.</div>
        <div class="status-container">
            <div class="status-box">
                <div class="status-number total">0</div>
                <div class="status-label">��ü</div>
            </div>
            <div class="status-box">
                <div class="status-number">0</div>
                <div class="status-label">�����Ϸ�</div>
            </div>
            <div class="status-box">
                <div class="status-number">0</div>
                <div class="status-label">����</div>
            </div>
            <div class="status-box">
                <div class="status-number">0</div>
                <div class="status-label">�հ�</div>
            </div>
            <div class="status-box">
                <div class="status-number">0</div>
                <div class="status-label">���հ�/���</div>
            </div>
        </div>
        <div class="tab-menu">
            <div class="tab active">�¶��Ρ����ڡ��̸��� ����</div>
            <div class="tab">��Ÿ ����</div>
            <div class="tab">���䳻��</div>
        </div>
        <div class="job-list">
            <div class="job-item">
                <div class="job-title">���� Ǫ�� - �߾Ӵ��б� ������ Ǫ��Ʈ�� ��� �˹�</div>
                <div class="job-meta">2024.06.27 | ���������� | ����</div>
                <div class="actions">
                    <button class="btn btn-gray">����ı� �ۼ��ϱ�</button>
                    <button class="btn btn-orange">�޸��ϱ�</button>
                </div>
            </div>
            <div class="job-item">
                <div class="job-title">�������� - �߾Ӵ��б� ������ �������� ���� �Ƹ�����Ʈ</div>
                <div class="job-meta">2024.06.06 | �¶������� | ����</div>
                <div class="actions">
                    <button class="btn btn-gray">����ı� �ۼ��ϱ�</button>
                    <button class="btn btn-orange">�޸��ϱ�</button>
                </div>
            </div>
            <div class="job-item">
                <div class="job-title">�������� - �߾Ӵ��б� ������ �������� ���� �Ƹ�����Ʈ</div>
                <div class="job-meta">2024.06.06 | �¶������� | ����</div>
                <div class="actions">
                    <button class="btn btn-gray">����ı� �ۼ��ϱ�</button>
                    <button class="btn btn-orange">�޸��ϱ�</button>
                </div>
            </div>
            <div class="job-item">
                <div class="job-title">�������� - �߾Ӵ��б� ������ �������� ���� �Ƹ�����Ʈ</div>
                <div class="job-meta">2024.06.06 | �¶������� | ����</div>
                <div class="actions">
                    <button class="btn btn-gray">����ı� �ۼ��ϱ�</button>
                    <button class="btn btn-orange">�޸��ϱ�</button>
                </div>
            </div>
            <div class="job-item">
                <div class="job-title">�������� - �߾Ӵ��б� ������ �������� ���� �Ƹ�����Ʈ</div>
                <div class="job-meta">2024.06.06 | �¶������� | ����</div>
                <div class="actions">
                    <button class="btn btn-gray">����ı� �ۼ��ϱ�</button>
                    <button class="btn btn-orange">�޸��ϱ�</button>
                </div>
            </div>
            <div class="job-item">
                <div class="job-title">�������� - �߾Ӵ��б� ������ �������� ���� �Ƹ�����Ʈ</div>
                <div class="job-meta">2024.06.06 | �¶������� | ����</div>
                <div class="actions">
                    <button class="btn btn-gray">����ı� �ۼ��ϱ�</button>
                    <button class="btn btn-orange">�޸��ϱ�</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
