---
title: "{{ replaceRE `^(\d+)-(.+)` "Episode $1: $2" .Name | replaceRE `-` " " | title }}"
date: {{ now.Format "2006-01-02" }}
---
