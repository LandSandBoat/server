-----------------------------------
-- Automaton heads and frames
-----------------------------------

xi = xi or {}
xi.automaton = xi.automaton or {}

---@enum xi.automaton.frame
xi.automaton.frame =
{
    HARLEQUIN  = 0x20,
    VALOREDGE  = 0x21,
    SHARPSHOT  = 0x22,
    STORMWAKER = 0x23,
}

---@enum xi.automaton.head
xi.automaton.head =
{
    HARLEQUIN    = 0x01,
    VALOREDGE    = 0x02,
    SHARPSHOT    = 0x03,
    STORMWAKER   = 0x04,
    SOULSOOTHER  = 0x05,
    SPIRITREAVER = 0x06,
}
