-----------------------------------
-- Area: Den of Rancor
-- Mob: Rancor Torch
-----------------------------------
local ID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minutes
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobDeath = function(mob, player, optParams)
    player:setCharVar('rancorCurse', 0) -- Player has been cleansed of the curse
end

-- Turns off all the lights once the NM despawns
entity.onMobDespawn = function(mob)
    for npcId = ID.npc.LANTERN_OFFSET + 15, ID.npc.LANTERN_OFFSET + 18 do
        local lantern = GetNPCByID(npcId)

        if lantern then
            lantern:setAnimation(xi.anim.CLOSE_DOOR) -- Turn off the light
        end
    end
end

return entity
