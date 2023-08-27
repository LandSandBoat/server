-----------------------------------
-- Area: Monarch Linn
--  Mob: Mammet-800
-----------------------------------
local ID = require("scripts/zones/Monarch_Linn/IDs")
-----------------------------------
local entity = {}

local changeForm = function(mob)
    local newform = math.random(0, 2)
    if mob:getAnimationSub() == newform then
        newform = 3
    end

    if newform == 0 then -- Hand Form, ~3s delay
        mob:setMagicCastingEnabled(false)
        mob:setDelay(3000)
        mob:setDamage(110)
    elseif newform == 1 then -- Sword Form, ~2s delay
        mob:setMagicCastingEnabled(false)
        mob:setDelay(2000)
        mob:setDamage(150)
    elseif newform == 2 then -- Polearm Form, ~3-3.5s delay
        mob:setMagicCastingEnabled(false)
        mob:setDelay(3500)
        mob:setDamage(175)
    elseif newform == 3 then -- Staff Form, ~4s delay, ~10 seconds between spell ends and next cast
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 10)
        mob:setMagicCastingEnabled(true)
        mob:setDelay(4000)
        mob:setDamage(90)
    end
    mob:setAnimationSub(newform)
    mob:setLocalVar('changeTime', mob:getBattleTime())
end

entity.onMobSpawn = function(mob)
    mob:setMagicCastingEnabled(false)
end

entity.onMobFight = function(mob, target)
    -- Mammets seem to be able to change to any given form, per YouTube videos
    -- Added a random chance to change forms every 3 seconds if 60 seconds have passed, just to make things less formulaic.
        -- May be able to change forms more often.  Witnessed one at ~50 seconds, most were 60-80.
        -- Believe it or not, these changes may be too slow @ 50% chance.  Probability is a pain.
    if mob:getBattleTime() > mob:getLocalVar('changeTime') + 60 or mob:getLocalVar('changeTime') == 0 and
       math.random(0, 1) == 1 and not mob:hasStatusEffect(xi.effect.FOOD) then
        changeForm(mob)
    end
end

entity.onMobEngaged = function(mob, target)
    -- This is actually called each time a mob engages from a passive stance - ensure to trigger spawn behavior once and only once
    local mobID = mob:getID()
    for _, v in pairs(ID.mob.MAMMET_800) do
        if mobID == v and mob:getLocalVar("AlreadyEngagedOnce") == 0 then -- If this is the initial Mammet-800 in a BCNM
            mob:setLocalVar("AlreadyEngagedOnce", 1) -- only trigger the additional spawn logic once - or if players wipe we could respawn mammets that were killed
            local players = mob:getBattlefield():getPlayers()
            for i = 3, #players, 2 do
                if i == 19 then
                    break
                end
                mobID = mobID + 1
                SpawnMob(mobID):updateEnmity(target)
            end
        end
    end
end

return entity
