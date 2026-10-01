# Study state

## Goal
- Outcome: Build an operation on compound data that remains valid when its representation changes.
- Why it matters: This is the central abstraction barrier in Chapter 2 and can inform interface design in the `shrimp` agent harness.

## Current loop
- Problem: Signal an error when `div_interval` receives a denominator interval spanning zero.
- Next learner action: Add a guard to `div_interval` that detects `(<= (lower_bound y) 0)` and `(>= (upper_bound y) 0)`, then signals `(error "..." y)`.
- Mode: practice
- Verification target: Division by `[0, 2]`, `[-1, 1]`, or `[-2, 0]` signals an error; division by `[2, 4]` proceeds.
- Latest result: not run - learner requested help with MIT Scheme error signaling.

## Evidence
- Can do independently: Explain why `add-rat` survives a representation change; identify the direct `Finding` field access that makes `shrimp/src/main.ts` depend on its current shape; write and explain a midpoint operation through constructors/selectors; define and verify interval selectors for a pair representation.
- Can do with a hint: Trace both selector values `0` and `1` for a concrete pair.
- Not yet demonstrated: Explain the substitution that verifies the procedural pair contract; derive the width identity algebraically; add and test the Exercise 2.10 guard.

## Misconceptions and gaps
- [ ] Has not distinguished the intermediate selector application from its final value - wrote `(car 'A 'B)`, then `'A` when asked for the intermediate step - revisit only if it affects a later task.
- [ ] Has not distinguished the intermediate selector application from its final value - wrote `(car 'A 'B)`, then `'A` when asked for the intermediate step - revisit only if it affects a later task.

## Scaffolding
- Current source: `/home/Qtmd/Programming/sicp/sicp.txt`, section 2.1.4, "Extended Exercise: Interval Arithmetic," Exercise 2.10.
- Current support for the next action: prompt
- Removal condition: Write the guard and verify both rejecting and accepting denominator intervals.

## Review and transfer
- Review when: After describing two rectangle representations and their shared interface.
- Transfer task: Revisit `Finding` in `/home/Qtmd/Projects/shrimp` when designing a stable consumer interface; the direct-field dependency has already been identified.
- Open questions: None.

## Project connection
- The learner wants `sicp` study and `shrimp` agent-harness building associated across future sessions. Use relevant `shrimp` examples to test transfer from SICP ideas, while keeping the SICP text and learner attempts as the primary study evidence.
