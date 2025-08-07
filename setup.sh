#!/bin/bash
#
# Tokgöz Dialogues - Setup and Deployment Script
# 
# @author Benjamin Tokgöz <https://github.com/benjamintokgoez>
# @created 2025-08-07
# @updated 2025-08-07
# @description Setup script for Jekyll blog and GitHub Pages deployment
# @license MIT
# 
# This script sets up the Jekyll blog and prepares it for deployment
# to GitHub Pages with automated workflows.
#
# Usage: ./setup.sh [local|deploy]
#

echo "🚀 Tokgoez Dialogues Setup"

set -e

COMMAND=${1:-dev}

echo "🚀 TokGoez Dialogues Setup"
echo "=========================="

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check dependencies
echo "📋 Checking dependencies..."

if ! command_exists ruby; then
    echo "❌ Ruby is not installed. Please install Ruby 2.7 or higher."
    exit 1
fi

if ! command_exists bundle; then
    echo "📦 Installing Bundler..."
    gem install bundler
fi

echo "✅ Dependencies check complete"

# Install gems
echo "📦 Installing Jekyll and dependencies..."
bundle install

case $COMMAND in
    "dev")
        echo "🔧 Starting development server..."
        echo "Your blog will be available at: http://localhost:4000"
        echo "Press Ctrl+C to stop the server"
        bundle exec jekyll serve --host 0.0.0.0 --port 4000 --livereload
        ;;
    
    "build")
        echo "🏗️  Building site for production..."
        JEKYLL_ENV=production bundle exec jekyll build
        echo "✅ Site built successfully in _site/"
        ;;
    
    "deploy")
        echo "🚀 Building and deploying to GitHub Pages..."
        
        # Check if we're in a git repository
        if [ ! -d ".git" ]; then
            echo "❌ Not in a Git repository. Please initialize git first:"
            echo "   git init"
            echo "   git remote add origin https://github.com/benjamintokgoez/tokgoezdialogues.git"
            exit 1
        fi
        
        # Build site
        JEKYLL_ENV=production bundle exec jekyll build
        
        # Commit and push
        git add .
        git commit -m "Deploy: $(date)"
        git push origin main
        
        echo "✅ Deployed to GitHub Pages!"
        echo "🌐 Your site will be available at: https://benjamintokgoez.github.io/tokgoezdialogues"
        ;;
    
    "new")
        echo "📝 Creating new post..."
        if [ -z "$2" ]; then
            echo "Usage: ./setup.sh new \"Post Title\" [tags]"
            echo "Example: ./setup.sh new \"My New Post\" \"AI,philosophy\""
            exit 1
        fi
        
        ./new-post.sh "$2" "$3"
        ;;
    
    "help"|*)
        echo "📖 Available commands:"
        echo "  dev     - Start development server (default)"
        echo "  build   - Build site for production"
        echo "  deploy  - Build and deploy to GitHub Pages"
        echo "  new     - Create a new post"
        echo "  help    - Show this help message"
        echo ""
        echo "Examples:"
        echo "  ./setup.sh dev"
        echo "  ./setup.sh build"
        echo "  ./setup.sh new \"My Post Title\" \"AI,philosophy\""
        ;;
esac
