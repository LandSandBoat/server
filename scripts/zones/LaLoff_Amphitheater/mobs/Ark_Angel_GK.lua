-----------------------------------
-- Area: LaLoff Amphitheater
--  Mob: Ark Angel GK
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

-- TODO: Allegedly has a 12 hp/sec regen.  Determine if true, and add to onMobInitialize if so.
-- TODO: Create listener for SCing with other AAs during DM

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = xi.jsa.CALL_WYVERN, hpp = 100, cooldown = 60}, -- "Call Wyvern is used at the time of monster engage. Call Wyvern is used ~1 minute subsequent to Wyvern's death."
            {id = xi.jsa.MEIKYO_SHISUI, hpp = math.random(90, 95), cooldown = 90}, -- "Meikyo Shisui is used very frequently."
        },
    })
end

entity.onMobEngaged = function(mob, target)
    local mobid = mob:getID()

    for member = mobid-6, mobid+1 do
        local m = GetMobByID(member)
        if m:getCurrentAction() == xi.act.ROAMING then
            m:updateEnmity(target)
        end
    end
end

entity.onMobFight = function(mob, target)
    if mob:hasStatusEffect(xi.effect.MEIKYO_SHISUI) then
        mob:setTP(0)
        if mob:getLocalVar("order") == 0 then
            mob:useMobAbility(946)
            mob:setLocalVar("order", 1)
        elseif mob:getLocalVar("order") == 1 then
            mob:useMobAbility(947)
            mob:setLocalVar("order", 2)
        else
            mob:useMobAbility(948)
            mob:setLocalVar("order", 0)
            mob:delStatusEffect(xi.effect.MEIKYO_SHISUI)
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
