-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Angra Mainyu
-- Note: Mega Boss
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobEngage = function(mob, target)
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 4 do
        local m = GetMobByID(i)
        if m and not m:isSpawned() then
            SpawnMob(i)
        end
    end
end

entity.onMobFight = function(mob, target)
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 4 do
        local pet = GetMobByID(i)
        if
            pet and
            pet:isSpawned() and
            pet:getCurrentAction() == xi.action.category.ROAMING
        then
            pet:updateEnmity(target)
        end
    end
end

entity.onMobMagicPrepare = function(mob, target, spellId)
    if mob:getHPP() <= 25 then
        return 244 -- Death
    else
        -- Can cast Blindga, Death, Graviga, Silencega, and Sleepga II.
        -- Casts Graviga every time before he teleports.
        local rnd = math.random(1, 100)

        if rnd <= 20 then
            return 361 -- Blindga
        elseif rnd <= 40 then
            return 244 -- Death
        elseif rnd <= 60 then
            return 366 -- Graviga
        elseif rnd <= 80 then
            return 274 -- Sleepga II
        else
            return 359 -- Silencega
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.megaBossOnDeath(mob, player, optParams)
end

return entity
