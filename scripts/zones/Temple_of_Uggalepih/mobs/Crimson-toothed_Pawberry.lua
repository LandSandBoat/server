-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Crimson-toothed Pawberry
-----------------------------------
require("scripts/globals/hunts")
mixins =
{
    require("scripts/mixins/families/tonberry"),
    require("scripts/mixins/job_special")
}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("petTimer", os.time() + 60)
    local mobID = mob:getID()
    local avatarID = mobID + 2
    local avatarMob = GetMobByID(avatarID)
    if avatarMob then
        -- Remove the original listener set from mixins/families/avatar
        avatarMob:removeListener("AVATAR_SPAWN")

        -- Replace with a similar listener which is hardcoded to use Carbuncle
        avatarMob:addListener("SPAWN", "AVATAR_SPAWN", function(mobArg)
            local modelId = 791 -- Carbuncle
            mobArg:setModelId(modelId)
            mobArg:hideName(false)
            mobArg:setUntargetable(true)
            mobArg:setUnkillable(true)
            mobArg:setAutoAttackEnabled(false)
            mobArg:setMagicCastingEnabled(false)

            -- If something goes wrong, the avatar will clean itself up in 5s
            mobArg:timer(5000, function(mobTimerArg)
                if mobTimerArg:isAlive() then
                    mobTimerArg:setUnkillable(false)
                    mobTimerArg:setHP(0)
                end
            end)
        end)
    end

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.ASTRAL_FLOW, hpp = 100, cooldown = 60 }, -- Uses Astral Flow on spawn and repeatedly through the fight
        },
    })
end

entity.onMobFight = function(mob)
    -- Spawns Fire/Light/Water Elemental 1 minute into the fight and at every astral flow if elemental dies
    local petSpawn = { 288, 293, 294 }
    local petID = mob:getID() + 1
    if os.time() > mob:getLocalVar("petTimer") and not GetMobByID(petID):isAlive() and mob:canUseAbilities() then
        local chance = math.random(1,3)
        mob:castSpell(petSpawn[chance], mob)
        mob:setLocalVar("petTimer", os.time() + 60)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 392)
end

return entity
