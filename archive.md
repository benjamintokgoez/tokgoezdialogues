---
layout: default
title: Archive
permalink: /archive/
---
<!--
/**
 * Tokgöz Dialogues - Archive Page
 * 
 * @author Benjamin Tokgöz <https://github.com/benjamintokgoez>
 * @created 2025-08-07
 * @updated 2025-08-07
 * @description Blog archive with search and filtering functionality
 * @license MIT
 */
-->

# Archive

<div class="archive-section">
  <div class="archive-intro">
    <p>A complete chronological archive of all dialogues and reflections. Use the search and filter options to find specific topics or conversations.</p>
  </div>

  <!-- Search and Filter -->
  <div class="archive-controls">
    <input type="text" id="search-input" placeholder="Search posts..." class="search-input">
    
    <div class="archive-filters">
      <select id="year-filter" class="filter-select">
        <option value="">All Years</option>
        {% assign years = site.posts | group_by_exp: "post", "post.date | date: '%Y'" | sort: "name" | reverse %}
        {% for year in years %}
          <option value="{{ year.name }}">{{ year.name }}</option>
        {% endfor %}
      </select>
      
      <select id="tag-filter-archive" class="filter-select">
        <option value="">All Tags</option>
        {% assign sorted_tags = site.tags | sort %}
        {% for tag in sorted_tags %}
          <option value="{{ tag[0] | slugify }}">{{ tag[0] }}</option>
        {% endfor %}
      </select>
    </div>
  </div>

  <!-- Posts by Year -->
  <div class="archive-timeline">
    {% assign postsByYear = site.posts | group_by_exp: "post", "post.date | date: '%Y'" | sort: "name" | reverse %}
    {% for year in postsByYear %}
      <div class="year-section" data-year="{{ year.name }}">
        <h2 class="year-heading">{{ year.name }}</h2>
        
        {% assign postsByMonth = year.items | group_by_exp: "post", "post.date | date: '%B'" %}
        {% assign months = "January,February,March,April,May,June,July,August,September,October,November,December" | split: "," %}
        
        {% for month in months %}
          {% assign monthPosts = postsByMonth | where: "name", month | first %}
          {% if monthPosts %}
            <div class="month-section">
              <h3 class="month-heading">{{ month }}</h3>
              <ul class="archive-posts">
                {% for post in monthPosts.items %}
                  <li class="archive-post-item" data-tags="{% for tag in post.tags %}{{ tag | slugify }} {% endfor %}" data-title="{{ post.title | downcase }}" data-content="{{ post.content | strip_html | downcase }}">
                    <div class="archive-post-date">
                      {{ post.date | date: "%d" }}
                    </div>
                    <div class="archive-post-content">
                      <h4 class="archive-post-title">
                        <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
                      </h4>
                      {% if post.tags.size > 0 %}
                        <div class="archive-post-tags">
                          {% for tag in post.tags %}
                            <span class="tag">{{ tag }}</span>
                          {% endfor %}
                        </div>
                      {% endif %}
                      <div class="archive-post-excerpt">
                        {{ post.excerpt | strip_html | truncatewords: 20 }}
                      </div>
                    </div>
                  </li>
                {% endfor %}
              </ul>
            </div>
          {% endif %}
        {% endfor %}
      </div>
    {% endfor %}
  </div>
</div>
