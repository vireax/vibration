---
layout: default
title: CCGA for vibration based damage detection in truss structures
---

# CCGA for VBDD #

{% if paginator.page == 1 %}
<ul>
  <li>Objective 1: To detect damage level in truss structure based on modal properties</li>
  <li>Objective 2: To detect damage with experimental noise</li>
</ul>

## Results ##

<ul>
<li>2D truss, 11 members (Rao,2004): a) undamaged, b) partially damaged, c) missing member 10</li>
<li>3D truss, 36 members (Nam Il Kim, 2013): a) <a href="http://vireax.github.io/vibration/truss36bars/">undamaged</a>, b) damaged (?) c) damaged (?) </li>  
</ul>
{% endif %}

<h2>Notes</h2>
<!-- Pagination links -->
{% if paginator.total_pages > 1 %}
<div class="pagination">
  {% if paginator.previous_page %}
    <!--a href="/page{{ paginator.previous_page }}" class="previous">Previous</a-->
    <a href="{{ paginator.previous_page_path | prepend: site.baseurl | replace: '//', '/' }}" class="previous">Newer</a>
  {% else %}    <span class="previous">Newer</span>  
  {% endif %}
  
  {% if paginator.next_page %}    
    <!--a href="/page{{ paginator.next_page }}" class="next">Next</a-->
    <a href="{{ paginator.next_page_path | prepend: site.baseurl | replace: '//', '/' }}" class="next">Older</a>
  {% else %}    <span class="next">Older</span>  
  {% endif %}
  
  <span class="page_number">Page: {{ paginator.page }} of {{ paginator.total_pages }}</span>
  <hr>
</div>
{% endif %}

<!-- This loops through the paginated posts -->
  <ul class="list-of-posts">
{% for post in paginator.posts %}
{% unless post.category == "review"%}
<li>
    <span class="index-post-date">{{ post.date | date_to_string }}</span> &raquo;  
    <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
</li>
{% endunless %}
{% endfor %}
 </ul>
 
<h2>Review</h2>
<ul class="list-of-posts">
{% for post in paginator.posts %}
{% if post.category == "review"%}
<li>
    <span class="index-post-date">{{ post.date | date_to_string }}</span> &raquo;  
    <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
</li>
{% endif %}
{% endfor %}
 </ul>

