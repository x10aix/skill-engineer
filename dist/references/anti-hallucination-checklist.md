# Anti-Hallucination Checklist

Dieses Dokument wird vom Skill-Engineer im **Qualitätsgate (Phase 4)** oder während eines **C-Audits** verwendet, um sicherzustellen, dass Agenten-Skills keine gefährlichen Annahmen treffen oder halluzinieren.

🇬🇧 *This document is bilingual. English instructions below.*

## 🇩🇪 Prüfkriterien (Deutsch)
1. **Tool-Verfügbarkeit:** Setzt der Skill Tools voraus (z.B. E-Mail-APIs, Browser-Steuerung, Webhooks), die die Zielplattform (Cursor, Antigravity, Claude Code) nicht nativ unterstützt?
2. **Framework-Korrektheit:** Existieren die im Ziel-Skill genannten Frameworks oder Modelle wirklich, oder sind sie vom LLM frei erfunden?
3. **Personen/Identitäten:** Wurden fiktive Referenzpersonen (z.B. "Du bist John Doe, Marketing Experte") vermieden bzw. echte verifiziert?
4. **Implizite Voraussetzungen:** Verlangt der Skill vom Nutzer Input, der in der Praxis logischerweise gar nicht vorliegen kann?
5. **Versionsangaben:** Werden veraltete, zukünftige oder schlicht nicht-existente Versionen von Software verlangt?

*Wenn einer dieser Punkte zutrifft, muss der Skill-Engineer den Entwurf iterieren, blockieren oder die betroffenen Stellen isoliert in der Code-Base mit dem XML-Tag `<!-- UNBESTÄTIGT: [Grund] -->` markieren.*

---

## 🇬🇧 Verification Criteria (English)
1. **Tool Availability:** Does the target skill assume tools (e.g., Email APIs, Browser Control, Webhooks) that the target platform (Cursor, Antigravity, Claude Code) does not natively support?
2. **Framework Accuracy:** Do the frameworks or models mentioned in the skill actually exist in reality, or were they hallucinated by the LLM?
3. **People/Identities:** Have fictional reference persons (e.g. "You are John Doe, Marketing Expert") been avoided or real ones verified?
4. **Implicit Prerequisites:** Does the skill demand input from the user that is practically unavailable or logically impossible to provide?
5. **Version Specifications:** Are obsolete, future, or simply non-existent versions of software required?

*If any of these points apply, the Skill-Engineer must iterate on the draft, block it, or isolate the affected areas in the codebase by marking them with the `<!-- UNCONFIRMED: [Reason] -->` XML tag.*
