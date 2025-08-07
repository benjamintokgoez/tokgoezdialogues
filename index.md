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
      {% assign visible_filter_tags = sorted_tags | slice: 0, 5 %}
      {% assign hidden_filter_tags = sorted_tags | slice: 5, sorted_tags.size %}
      
      {% for tag in visible_filter_tags %}
        <button class="tag-btn" data-tag="{{ tag[0] | slugify }}">{{ tag[0] }}</button>
      {% endfor %}
      
      {% if hidden_filter_tags.size > 0 %}
        <span class="filter-tags-hidden" id="hidden-filter-tags" style="display: none;">
          {% for tag in hidden_filter_tags %}
            <button class="tag-btn" data-tag="{{ tag[0] | slugify }}">{{ tag[0] }}</button>
          {% endfor %}
        </span>
        <button class="filter-toggle-btn" onclick="toggleFilterTags()" aria-expanded="false">
          <span class="filter-toggle-text">+{{ hidden_filter_tags.size }} more topics</span>
        </button>
      {% endif %}
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
                {%- assign visible_tags = post.tags | slice: 0, 3 -%}
                {%- assign hidden_tags = post.tags | slice: 3, post.tags.size -%}
                
                {%- for tag in visible_tags -%}
                  <span class="tag">{{ tag }}</span>
                {%- endfor -%}
                
                {%- if hidden_tags.size > 0 -%}
                  <span class="tags-hidden" id="hidden-tags-{{ forloop.index }}" style="display: none;">
                    {%- for tag in hidden_tags -%}
                      <span class="tag">{{ tag }}</span>
                    {%- endfor -%}
                  </span>
                  <button class="tag-toggle-btn" onclick="toggleTags({{ forloop.index }})" aria-expanded="false">
                    <span class="toggle-text">+{{ hidden_tags.size }} more</span>
                  </button>
                {%- endif -%}
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

// Tag toggle functionality for individual posts
function toggleTags(postIndex) {
    const hiddenTags = document.getElementById('hidden-tags-' + postIndex);
    const toggleBtn = hiddenTags.nextElementSibling;
    const toggleText = toggleBtn.querySelector('.toggle-text');
    const isExpanded = toggleBtn.getAttribute('aria-expanded') === 'true';
    
    if (isExpanded) {
        hiddenTags.style.display = 'none';
        toggleText.textContent = '+' + hiddenTags.children.length + ' more';
        toggleBtn.setAttribute('aria-expanded', 'false');
    } else {
        hiddenTags.style.display = 'inline';
        toggleText.textContent = 'show less';
        toggleBtn.setAttribute('aria-expanded', 'true');
    }
}

// Tag filter toggle functionality
function toggleFilterTags() {
    const hiddenTags = document.getElementById('hidden-filter-tags');
    const toggleBtn = document.querySelector('.filter-toggle-btn');
    const toggleText = toggleBtn.querySelector('.filter-toggle-text');
    const isExpanded = toggleBtn.getAttribute('aria-expanded') === 'true';
    
    if (isExpanded) {
        hiddenTags.style.display = 'none';
        // Count hidden tags by counting buttons inside
        const hiddenCount = hiddenTags.querySelectorAll('.tag-btn').length;
        toggleText.textContent = '+' + hiddenCount + ' more topics';
        toggleBtn.setAttribute('aria-expanded', 'false');
    } else {
        hiddenTags.style.display = 'inline';
        toggleText.textContent = 'show less';
        toggleBtn.setAttribute('aria-expanded', 'true');
    }
}
</script>
