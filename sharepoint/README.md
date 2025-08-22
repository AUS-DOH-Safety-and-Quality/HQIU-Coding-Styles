---
title: "SharePoint Naming Convention Guide"
author: "Head of Healthcare Quality Intelligence Unit (HQIU), Patient Safety & Clinical Quality (PSCQ) Directorate"
date: "`r Sys.Date()`"
output: html_document
---

# Purpose 

This guide outlines the naming conventions used for organising folders and files in SharePoint.

It also compares these conventions with SharePoint best practices.

Maintaining reproducibility and transparency is a core value the Healthcare Quality Intelligence team, and this guide helps us achieve that goal. Additionally, sticking to the basic rules in this style guide will improve our ability to share, maintain, and extend our work to healthcare staff.

This document is written as a manual for anyone working in the HQIU team, but also as a guide for anyone who would like to write clean and clear code that is meant to be shared.

# Current Naming Conventions

## File Naming Structure

- **Date Format**: `YYYY MM [document type] [subject]`
  - Example: `2026 08 BN Define New Coding Styles`
- **Document types** 
  - `BN`: Briefing Note
- **Document Target - Abbreviations used in file names may indicate who a document is TO:**:
  - `DG`: Director General
  - `NCR`: National Cardiac Registry
- **Attachment Descriptive Titles**:
  - **Attachments to BNs often describe what the document is in detail, to meet requirements of the Department**
  - `DG Nomination Letter National Board`
  - `Board Director Appointment`
- **Structured Lists**: which may be used in dataflows or other coding products should follow the R style guide, e.g. 
  - `indicator_list`
  - `retired_indicator_list`
  - `hospitals_list`

# General Practices

| Best Practice | Description |
|---------------|-------------|
| Descriptive Folders | Use clear, meaningful names and keep files in the same place |
| Descriptive File Names | Use clear, meaningful names and remember that the parent folder gives context |
| Avoid Generic Terms | Avoid vague terms like “misc” |
| Date Format | Use `YYYY MM` for sorting |
| Consistent Abbreviations | Use standard, documented abbreviations |
| Avoid Special Characters | Do not use `\ / : * ? " < > |` |
| Version Control | Enable versioning in document libraries |
| Folder Numbering | Use two-digit sequences (`01`, `02`, etc.) |

## Folder Organisation

- Subject-based grouping (e.g., '01 indicators', '02 hospitals', '03 dictionaries')
- Archiving old material is fine, please use '99 archive', if you have a current 'archive' you don't need to change it.
- Status tracking using terms like “Approved” or “Retired” should be avoided, as these duplicate files. By using SharePoint's built in version control, you can reduce the number of duplicate files.


1. **Document Abbreviations**: Reuse our existing glossary of abbreviations - don't recreate.
2. **Enable Version Control**: Ensure versioning is active in SharePoint libraries, typically this is enabled by default.
3. **Create Templates**: Provide naming templates for common document types.

# Conclusion

Our current naming conventions are largely aligned with the WA Health Style Guide, existing coding standards and SharePoint best practices. With minor adjustments.
