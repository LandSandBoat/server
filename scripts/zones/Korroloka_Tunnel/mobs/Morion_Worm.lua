-----------------------------------
-- Area: Korroloka Tunnel (173)
--  Mob: Morion Worm
-----------------------------------
local korrolokaGlobal = require('scripts/zones/Korroloka_Tunnel/globals')
local ID              = zones[xi.zone.KORROLOKA_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 min despawn when deaggroed
    mob:setMod(xi.mod.REGEN, 5)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobFight = function(mob, target)
    if mob:getBattleTime() > 60 * 30 and mob:getLocalVar('despawning') == 0 then -- Despawns after 30 minutes
        mob:setLocalVar('despawning', 1)

        -- TODO: verify if this force disengages players. this should probably be generic worm behavior.
        -- go into ground
        mob:setAnimationSub(1)
        -- despawn in a few seconds
        mob:timer(2000, function(mobArg)
            if mobArg:isAlive() then -- if its alive despawn, else let the normal code handle it
                DespawnMob(mobArg:getID())
                mobArg:messageText(mobArg, ID.text.MORION_WORM_1 + 2, false)
            end

            mobArg:setLocalVar('despawning', 0)
        end)
    end
end

entity.onMobDespawn = function(mob)
    -- respawn QM 15 minutes
    mob:timer(60 * 15 * 1000, function()
        local qm1 = GetNPCByID(ID.npc.MORION_WORM_QM)

        -- move qm and set timer
        korrolokaGlobal.moveMorionWormQM()

        -- unhide qm
        if qm1 then
            qm1:setStatus(xi.status.NORMAL)
        end
    end)
end

return entity
