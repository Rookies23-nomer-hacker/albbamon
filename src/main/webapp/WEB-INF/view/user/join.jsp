<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>albbamon ȸ������</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #ffffff;
            flex-direction: column;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 900px;
            display: flex;
            flex-direction: column;
            align-items: center;
            border: 2px solid #ff6600;
        }
        .logo {
            width: 100%;
            padding: 10px 0;
            text-align: center;
            border-bottom: 2px;
            margin-bottom: 20px;
        }
        .logo h1 {
            font-size: 32px;
            font-weight: bold;
            color: #ff6600;
            margin: 0;
        }
        .sections {
            display: flex;
            justify-content: space-between;
            width: 100%;
        }
        .section {
            width: 48%;
            padding: 20px;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .section h2 {
            font-size: 22px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }
        .section p {
            font-size: 14px;
            color: #666;
            margin-bottom: 20px;
        }
        .signup-btn {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .personal-btn {
            background-color: #ff6600;
            color: white;
        }
        .personal-btn:hover {
            background-color: #e55a00;
        }
        .business-btn {
            background-color: #333;
            color: white;
        }
        .business-btn:hover {
            background-color: #555;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">
            <h1>albbamon</h1>
        </div>
        <div class="sections">
            <div class="section">
                <h2 style="color: #ff6600;">���� ȸ��</h2>
                <p>�̷¼��� ����ϰ� �˹ٸ� ã�ƺ�����</p>
                <button class="signup-btn personal-btn" onclick="location.href='http://localhost:60083/api/user'">���� ���� ȸ������</button>
                <p style="font-size: 12px; color: #888; margin-top: 10px;">* ��� ��� ���</p>
            </div>
            <div class="section">
                <h2 style="color: #333;">��� ȸ��</h2>
                <p>���� ����ϰ� ���縦 ã�ƺ�����</p>
                <button class="signup-btn business-btn" onclick="location.href='http://localhost:60083/api/user/ceo'">���� ��� ȸ������</button>
                <p style="font-size: 12px; color: #888; margin-top: 10px;">* �˹ٸ� ä���Ͻô� ���λ����, ���ü ���� ����</p>
            </div>
        </div>
    </div>
</body>
</html>