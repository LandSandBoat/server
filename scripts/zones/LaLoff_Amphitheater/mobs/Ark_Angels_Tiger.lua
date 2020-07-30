-----------------------------------
-- Area: LaLoff Amphitheater
--  Mob: Ark Angel's Tiger
-----------------------------------
require("scripts/globals/status")
-----------------------------------

-- TODO: Implement shared spawning and victory system with Ark Angel's Mandragora.

function onMobEngaged(mob, target)
    local mobid = mob:getID()

    for member = mobid-2, mobid+5 do
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
