-----------------------------------
-- Area: Spire of Mea
--  Mob: Envier
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.REGAIN, 150)
end

entity.onMobEngage = function(mob)
    mob:setLocalVar('seetherTimer', GetSystemTime() + math.random(15, 120)) -- Envier summons Seether every 15 to 120 seconds.
end

entity.onMobFight = function(mob, target)
    local battlefield = mob:getBattlefield()
    local envierHPP = mob:getHPP()
    if battlefield then
        battlefield:setLocalVar('envierHPP', envierHPP)
    end

    if mob:getLocalVar('seetherTimer') < GetSystemTime() then
        mob:setLocalVar('seetherTimer', GetSystemTime() + math.random(15, 120))
        local envierID = mob:getID()
        local pets = { envierID + 1, envierID + 2, envierID + 3 }
        local petParams =
        {
            maxSpawns = 1,
            noAnimation = true,
            dieWithOwner = true,
            superlink = true,
            ignoreBusy = true,
        }
        xi.mob.callPets(mob, pets, petParams)
    end
end

return entity
