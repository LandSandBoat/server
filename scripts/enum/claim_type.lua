-----------------------------------
-- Claim type
-----------------------------------
xi = xi or {}

---@enum xi.claimType
xi.claimType =
{
    EXCLUSIVE     = 0, -- Regular exclusive claim behavior. Only one entity and related group can attack.
    NON_EXCLUSIVE = 1, -- Regular claim behavior but multiple unrelated entities can attack and compete for claim. Rewards distributed to last claiming entity.
    UNCLAIMABLE   = 2, -- Mob cannot be claimed. Multiple unrelated entities can attack. Rewards will not be distributed.
}
