-----------------------------------
-- Follow Behavior
-----------------------------------
xi = xi or {}

xi.followType =
{
    NONE     = 0,
    ROAM     = 1, -- Mob will follow the target while roaming
    RUN_AWAY = 2, -- Mob will run away while in combat to the follow target
}
