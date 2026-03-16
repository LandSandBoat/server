# Decision Records

Use this folder for non-trivial decisions that affect architecture, customization strategy, upstream mergeability, or client-vs-server boundaries.

## Naming

- `YYYY-MM-DD-short-decision.md`

## Record when

- a module is preferred over a core edit for a lasting reason
- a core edit is required because modules are insufficient
- a customization changes upstream merge risk
- server and client responsibilities must be split across separate tracks
- a content or runtime interpretation becomes the project standard

## Include in each record

- context
- confirmed facts
- decision
- alternatives considered
- mergeability risk
- validation impact
- rollback or reversal path
