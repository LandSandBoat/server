-----------------------------------
-- Area: LaLoff Amphitheater
--  Mob: Ark Angel's Wyvern
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobEngaged(mob, target)
    local mobid = mob:getID()

    for member = mobid-7, mobid do
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
