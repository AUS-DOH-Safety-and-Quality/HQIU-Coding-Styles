# HQIU Coding Styles
Repository for documenting and implementing linter configurations for coding styles.

Please see each repo for more detailed guides on coding styles for each language.

## Non coding styles

The official Department of Health Style Guide previously specified a Vancouver style, but in 2021 recommended the style preferred by the readership (if publishing in Journals).  For ease, either the APA standard or the Vancouver style (more commonly used in medical journals) are fine.


Here is the **Markdown-formatted** guidance, ready to paste into SharePoint, Teams, GitHub, or a policy document.

***

```markdown
# HQIU Guidance: Storage of Code, Files & Use of GitHub
**Clinical Excellence Division – Healthcare Quality Intelligence Unit**

## 1. Purpose
This guidance sets clear, unit‑wide expectations for how HQIU staff store, manage, and collaborate on code and related artefacts. It reflects good security practice and aligns with our approved use of GitHub as the system of record for source code.

---

## 2. Good Practice Principles (Summary)
- **Do not store HQIU work on personal devices or personal OneDrive.**
- **GitHub is the single source of truth for all code. Push changes daily.**
- **Outputs and datasets must live in SharePoint or WA Health data platforms, not GitHub.**
- **Maintain GitHub hygiene: delete stale branches, use standard `.gitignore`, avoid sensitive data.**

---

## 3. Storage Rules

### 3.1 No personal devices or personal OneDrive
To minimise risk, ensure traceability and maintain governance, HQIU staff must **not**:
- Store any HQIU work (code, data, documentation, reports) on **shared computers**.
- Save HQIU work in **personal OneDrive accounts** or any non-WA Health storage.

Use **WA Health–managed** devices and storage locations only.

---

### 3.2 Approved storage locations

| Item | Approved | Not approved |
|------|----------|--------------|
| **Source code (R, Python, SQL, TypeScript)** | GitHub (HQIU organisation) – DEV/UAT branches; temporary local clones on **WA Health–managed** laptops | Personal OneDrive; personal devices |
| **Outputs, reports, data extracts** | SharePoint; WA Health Data Platform (e.g., Snowflake) | GitHub; personal storage |
| **Documentation & operational files** | SharePoint; Teams | Local storage on a **WA Health–managed** laptop only when syncing with OneDrive to SharePoint |

---

## 4. GitHub Requirements (WA Health Department HQIU Practice)

- **Single source of truth:**  
  All code — including work‑in‑progress — must be stored within the HQIU GitHub organisation on **DEV** or **UAT** branches.

- **Daily push:**  
  Commit locally during the day, then **push all changes to GitHub by close of business**.

- **Local clones only on managed devices:**  
  Local copies for development must be on **WA Health–managed laptops only** and synced regularly.

- **Repository hygiene:**  
  - Delete branches once merged into `main`.  
  - Remove stale or abandoned branches (rule of thumb: *if it’s older than mouldy cheese, it’s gone*).  
  - Use HQIU-standard `.gitignore` files.

- **No sensitive data in GitHub:**  
  - Do not commit personally identifiable information, patient identifiers, secrets, credentials, environment files, or model outputs.
  - Use scrubbers or secrets‑scanners before pushing.

- **Outputs do not belong in GitHub:**  
  Reports, datasets, extracts, and model outputs must be stored in SharePoint or WA Health data platforms, **not** in the repository.

---

## 5. Exceptions & Escalation

- **Temporary exceptions** (e.g., troubleshooting, ) must be agreed in advance with the HQIU Lead and must include a disposal or migration plan.
- **Testing data** note that some repositories may have dummy, testing data. This data is artificially generated for testing purposes.  
- **If you identify a file** (e.g., real data in GitHub, unapproved storage, personal device usage), report immediately to your line manager or HQIU Lead.

---

## 6. Why We Do This (Rationale)
- Centralised code management improves **traceability, reproducibility, collaboration, and continuity**.  
- Using approved WA Health storage ensures **auditability, governance, and alignment with information management principles**.  
- Avoiding personal storage reduces risks of **breaches through theft, unintentional disclosure, version drift, and unmanaged copies**.

---

## 7. Practical Quick Checks

**Before pushing to GitHub:**
- `git status` shows no unintended files.  
- Sensitive files are covered by `.gitignore`.  
- No secrets or credentials in code or config, see our internal guidance (not on Github) for best practice.

**After merging to `main`:**
- Delete the feature branch (local and remote).

If you want this converted into **PDF**, **Word**, or a **SharePoint page layout**, I can generate that for you too.

