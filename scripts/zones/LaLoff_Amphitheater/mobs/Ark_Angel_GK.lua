-----------------------------------
-- Area: LaLoff Amphitheater
--  Mob: Ark Angel GK
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------

-- TODO: Allegedly has a 12 hp/sec regen.  Determine if true, and add to onMobInitialize if so.

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.CALL_WYVERN, hpp = 100, cooldown = 60}, -- "Call Wyvern is used at the time of monster engage. Call Wyvern is used ~1 minute subsequent to Wyvern's death."
            {id = tpz.jsa.MEIKYO_SHISUI, hpp = math.random(90, 95), cooldown = 90}, -- "Meikyo Shisui is used very frequently."
        },
    })
end

function onMobEngaged(mob, target)
    local mobid = mob:getID()

    for member = mobid-6, mobid+1 do
        local m = GetMobByID(member)
        if m:getCurrentAction() == tpz.act.ROAMING then
            m:updateEnmity(target)
        end
    end
end

function onMobFight(mob, target)
    -- TODO: AA GK actively seeks to skillchain to Light off of his own WSs under MS, or other AA's WSs.
end

function onMobDeath(mob, player, isKiller)
end
