create table highschool_menu(
menu_date date,
menu_name varchar2(50),
menu_order number(1),
select_count number default 0
);


SELECT * FROM HIGHSCHOOL_MENU;
=======
-------------------------------
insert into highschool_menu values('20240930', '���ҹ�',0);
insert into highschool_menu values('20240930', '�Ұ�� �����쵿',0);
insert into highschool_menu values('20240930', '��ġ��ġ�',0);
insert into highschool_menu values('20241002', '���벢�ٺ���',0);
insert into highschool_menu values('20241002', '��������',0);
insert into highschool_menu values('20241002', '���߰�����',0);
insert into highschool_menu values('20241002', '��������',0);
insert into highschool_menu values('20241007', '��������',0);
insert into  highschool_menu values('20241007','������ �ᳪ����',0);
insert into highschool_menu values('20241007', '������ �߰���',0);
insert into highschool_menu values('20241007', '��¡���ġ��',0);
insert into highschool_menu values('20241007', '���߰�����',0);
insert into highschool_menu values('20241007', '��',0);
insert into highschool_menu values('20241008', '���ҹ�',0);
insert into highschool_menu values('20241008', '�δ��',0);
insert into highschool_menu values('20241008', '���ķ�����',0);
insert into highschool_menu values('20241008', '�������� ġ�� ���±/�ҽ�',0);
insert into highschool_menu values('20241008', '�Ѱ���ġ',0);
insert into highschool_menu values('20241008', '��������',0);

insert into highschool_menu values('20241010', '��������',0);
insert into highschool_menu values('20241010', '������',0);
insert into highschool_menu values('20241010', '�ǻ���ٴ뱹',0);
insert into highschool_menu values('20241010', '���κΰ����',0);
insert into highschool_menu values('20241010', '�����Ұ��',0);
insert into highschool_menu values('20241010', '���߱�ġ',0);
insert into highschool_menu values('20241011', '��',0);
insert into highschool_menu values('20241011', '��������',0);
insert into highschool_menu values('20241011', 'ũ���뽺��',0);
insert into highschool_menu values('20241011', '�������� ��ġ',0);
insert into highschool_menu values('20241011', '������ ��',0);
insert into highschool_menu values('20241011', '��ƽ ���ڹ�',0);
insert into highschool_menu values('20241014', '��̹�',0);
insert into highschool_menu values('20241014', '������',0);
insert into highschool_menu values('20241014', '�볪������',0);
insert into highschool_menu values('20241014', '������ġ����',0);
insert into highschool_menu values('20241014', '��¡���ä����',0);
insert into highschool_menu values('20241014', '���ٱ�ġ',0);
insert into highschool_menu values('20241015', '�ܾ�ä������',0);
insert into highschool_menu values('20241015', '���ε��屹',0);
insert into highschool_menu values('20241015', '����Ŭ',0);
insert into highschool_menu values('20241015', '�� ǰ�� ��ȣ��',0);
insert into highschool_menu values('20241015', '��ī��/�ҽ�',0);
insert into highschool_menu values('20241015', '���߰�����',0);
insert into highschool_menu values('20241016', 'ȥ������',0);
insert into highschool_menu values('20241016', '��ġ��ġ�',0);
insert into highschool_menu values('20241016', '����ġŲ������',0);
insert into highschool_menu values('20241016', '������ä',0);
insert into highschool_menu values('20241016', '�Ѱ���ġ',0);
insert into highschool_menu values('20241016', '������',0);
insert into highschool_menu values('20241016', '�ܶ�',0);
insert into highschool_menu values('20241017', '��巹������/��������',0);
insert into highschool_menu values('20241017', '���̹��������',0);
insert into highschool_menu values('20241017', 'ġ����',0);
insert into highschool_menu values('20241017', '������ġ',0);
insert into highschool_menu values('20241017', '��',0);
--------------------------------------------------------------------
SELECT * FROM HIGHSCHOOL_MENU;
SELECT COUNT(*), MENU_DATE,sum(select_count)/count(*) FROM HIGHSCHOOL_MENU GROUP BY MENU_DATe order by 3 desc,2;
SELECT menu_date, menu_name, select_count FROM highschool_menu ORDER BY select_count DESC,1,2;

SELECT 
    h1.menu_date, 
    h1.menu_name, 
    h1.select_count, 
    COUNT(*) OVER(PARTITION BY h1.menu_date) AS menu_count, 
    AVG(h1.select_count) OVER(PARTITION BY h1.menu_date) AS avg_select_count
FROM 
    highschool_menu h1
ORDER BY 
    avg_select_count DESC, 
    h1.menu_date, 
    h1.menu_name;


>>>>>>> Stashed changes

commit;

SELECT TO_CHAR(menu_date, 'YYYYMMDD') AS menu_date,
       LISTAGG(menu_name, ', ') WITHIN GROUP (ORDER BY menu_name) AS menu_names
FROM highschool_menu
GROUP BY TO_CHAR(menu_date, 'YYYYMMDD')
ORDER BY menu_date;
