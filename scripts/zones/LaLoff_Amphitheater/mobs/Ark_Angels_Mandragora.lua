-----------------------------------
-- Area: LaLoff Amphitheater
--  Mob: Ark Angel's Mandragora
-----------------------------------
require("scripts/globals/status")
-----------------------------------

-- TODO: Determine spell list and behavior.  Potentially includes Breakga and Bindga, unless they're TP moves.
-- TODO: Implement shared spawn and victory conditions with Ark Angel's Tiger.

function onMobEngaged(mob, target)
    local mobid = mob:getID()

    for member = mobid-3, mobid+4 do
        local m = GetMobByID(member)
        if m:getCurrentAction() == tpz.act.ROAMING then
            m:updateEnmity(target)
        end
    end
end

function onMobFight(mob, target)

end

function onMobDeath(mob, player, isKiller)
end
