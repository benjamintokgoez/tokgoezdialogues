---
layout: default
---

<div class="home">
  {%- if page.title -%}
    <h1 class="page-heading">{{ page.title }}</h1>
  {%- endif -%}

  <div class="intro-section">
    <h2>Tokgöz Dialogues</h2>
    <p class="intro-text">
      Space for the intro.
    </p>
   
    <div class="about-me">
      <p>
        <strong>About me:</strong> Short about me text
      </p>
    </div>
  </div>

  <!-- Tag Filter Section -->
  <div class="tag-filter-section">
    <h3>Filter by Topic</h3>
    <div id="tag-filter" class="tag-filter">
      <button class="tag-btn active" data-tag="all">All Posts</button>
      {% assign sorted_tags = site.tags | sort %}
      {% for tag in sorted_tags %}
        <button class="tag-btn" data-tag="{{ tag[0] | slugify }}">{{ tag[0] }}</button>
      {% endfor %}
    </div>
  </div>

  {%- if site.posts.size > 0 -%}
    <div class="posts-section">
      <h3>Recent Dialogues</h3>
      <ul class="post-list" id="post-list">
        {%- assign date_format = site.minima.date_format | default: "%b %-d, %Y" -%}
        {%- for post in site.posts -%}
        <li class="post-item" data-tags="{% for tag in post.tags %}{{ tag | slugify }} {% endfor %}">
          <div class="post-meta">
            <span class="post-date">{{ post.date | date: date_format }}</span>
            {%- if post.tags.size > 0 -%}
              <div class="post-tags">
                {%- for tag in post.tags -%}
                  <span class="tag">{{ tag }}</span>
                {%- endfor -%}
              </div>
            {%- endif -%}
          </div>
          <h3>
            <a class="post-link" href="{{ post.url | relative_url }}">
              {{ post.title | escape }}
            </a>
          </h3>
          {%- if site.show_excerpts -%}
            <div class="post-excerpt">
              {{ post.excerpt }}
            </div>
          {%- endif -%}
        </li>
        {%- endfor -%}
      </ul>
    </div>
  {%- endif -%}

</div>

<script>
// Tag filtering functionality
document.addEventListener('DOMContentLoaded', function() {
    const tagButtons = document.querySelectorAll('.tag-btn');
    const postItems = document.querySelectorAll('.post-item');
    
    tagButtons.forEach(button => {
        button.addEventListener('click', function() {
            const selectedTag = this.getAttribute('data-tag');
            
            // Update active button
            tagButtons.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');
            
            // Filter posts
            postItems.forEach(item => {
                const postTags = item.getAttribute('data-tags');
                
                if (selectedTag === 'all' || postTags.includes(selectedTag)) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
        });
    });
});
</script>
