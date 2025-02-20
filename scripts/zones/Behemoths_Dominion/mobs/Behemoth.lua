-----------------------------------
-- Area: Behemoth's Dominion
--  HNM: Behemoth
-----------------------------------
local ID = zones[xi.zone.BEHEMOTHS_DOMINION]
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 1800) -- 30 minutes
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 37) -- 109 total weapon damage
    mob:setMod(xi.mod.EVA, 301)
    mob:setMod(xi.mod.ATT, 211)

    -- Despawn the ???
    GetNPCByID(ID.npc.BEHEMOTH_QM):setStatus(xi.status.DISAPPEAR)
end

entity.onMobRoam = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobFight = function(mob, target)
    local drawInTable =
    {
        conditions =
        {
            target:getXPos() > -180 and target:getZPos() > 53,
            target:getXPos() > -230 and target:getZPos() < 5,
        },
        position = mob:getPos(),
        wait = 3,
    }
    for _, condition in ipairs(drawInTable.conditions) do
        if condition then
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            utils.drawIn(target, drawInTable)
            break
        else
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.BEHEMOTHS_BANE)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    GetNPCByID(ID.npc.BEHEMOTH_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
