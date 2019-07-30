select * from 
(
select * from ho_goods where 1=1 and status='1'
<#if form.hospital_nature?? && form.hospital_nature!="">
	and hospital_nature=#{form.hospital_nature}
</#if>
<#if form.queryStr?? && form.queryStr!="">
	and (name like '%'||#{form.queryStr}||'%' or no||'' like '%'||#{form.queryStr}||'%' or product_name like '%'||#{form.queryStr}||'%')
</#if>

) temp1
left join 
(
select goods.goods_id,count(1) cnt from ho_offer_goods goods where goods.status='1' and type='1' group by goods.goods_id order by cnt desc
) temp2 on temp1.id = temp2.goods_id
order by COALESCE(temp2.cnt,0) desc