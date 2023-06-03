-----------------------------------
-- Area: The Ashu Talif (Against All Odds)
--  Mob: Yazquhl
-----------------------------------
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.SLEEP_MEVA, 150)
    mob:addMod(xi.mod.SILENCE_MEVA, 150)
    mob:addListener("WEAPONSKILL_STATE_ENTER", "WS_START_MSG", function(mobArg, skillId)
        -- Vorpal Blade
        if skillId == 40 then
            mobArg:showText(mobArg, ID.text.TAKE_THIS)
        -- Circle Blade
        elseif skillId == 38 then
            mobArg:showText(mobArg, ID.text.REST_BENEATH)
        -- Savage Blade
        elseif skillId == 35 then
            mobArg:showText(mobArg, ID.text.STOP_US)
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    mob:showText(mob, ID.text.YAZQUHL_DEATH)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

return entity
