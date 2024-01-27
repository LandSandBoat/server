-----------------------------------
-- Area: LaLoff Amphitheater
--  Mob: Ark Angel GK
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

-- TODO: Allegedly has a 12 hp/sec regen.  Determine if true, and add to onMobInitialize if so.
-- TODO: Create listener for SCing with other AAs during DM

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            -- "Call Wyvern is used at the time of monster engage. Call Wyvern is used ~1 minute subsequent to Wyvern's death."
            {
                id       = xi.jsa.CALL_WYVERN,
                hpp      = 100,
                cooldown = 60,
            },

            -- "Meikyo Shisui is used very frequently."
            {
                id       = xi.jsa.MEIKYO_SHISUI,
                hpp      = math.random(90, 95),
                cooldown = 90,

                begCode = function(mobArg)
                    mobArg:setLocalVar('order', 0)
                end,
            },
        },
    })
end

entity.onMobEngaged = function(mob, target)
    local mobid = mob:getID()

    for member = mobid-6, mobid + 1 do
        local m = GetMobByID(member)
        if m:getCurrentAction() == xi.act.ROAMING then
            m:updateEnmity(target)
        end
    end
end

entity.onMobFight = function(mob, target)
    if mob:hasStatusEffect(xi.effect.MEIKYO_SHISUI) then
        if mob:getLocalVar('order') == 0 then
            mob:useMobAbility(946) -- Tachi - Yukikaze
            mob:setLocalVar('order', 1)
            mob:setTP(2000)
        elseif mob:getLocalVar('order') == 1 then
            mob:useMobAbility(947) -- Tachi - Gekko
            mob:setLocalVar('order', 2)
            mob:setTP(1000)
        elseif mob:getLocalVar('order') == 2 then
            mob:useMobAbility(948) -- Tachi - Kasha
            mob:setLocalVar('order', 3)
            mob:setTP(0)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
