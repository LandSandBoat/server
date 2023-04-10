-----------------------------------
-- Area: Grand Palace of HuXzoi
--  Mob: Ix'aern MNK
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
require("scripts/globals/items")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addListener("ITEM_DROPS", "ITEM_DROPS_IXAERN_MNK", function(mobArg, loot)
        local rate = mob:getLocalVar("[SEA]IxAern_DropRate")
        loot:addGroupFixed(rate,
        {
            { item = xi.items.DEED_OF_PLACIDITY, weight = 750 },
            { item = xi.items.VICE_OF_ANTIPATHY, weight = 250 },
        })
    end)
end

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(1) -- Reset the subanim - otherwise it will respawn with bracers on. Note that Aerns are never actually supposed to be in subanim 0.
end

entity.onMobFight = function(mob, target)
    -- The mob gains a huge boost when it 2hours to attack speed and attack.
    -- It forces the minions to 2hour as well. Wiki says 50% but all videos show 60%.
    if mob:getLocalVar("BracerMode") == 0 then
        if mob:getHPP() < math.random(50, 60) then
            -- Go into bracer mode
            mob:setLocalVar("BracerMode", 1)
            mob:setAnimationSub(2)
            mob:addMod(xi.mod.ATT, 200)
            mob:addMod(xi.mod.HASTE_ABILITY, 1500)
            mob:useMobAbility(3411) -- Hundred Fists

            -- Force minions to 2hour
            for i = 1, 2 do
                local minion = GetMobByID(mob:getID() + i)
                if minion:getCurrentAction() ~= xi.act.NONE then
                    minion:useMobAbility(3411 + i) -- Chainspell or Benediction
                end
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    DespawnMob(mob:getID() + 1)
    DespawnMob(mob:getID() + 2)
end

entity.onMobDespawn = function(mob)
    DespawnMob(mob:getID() + 1)
    DespawnMob(mob:getID() + 2)

    local qm = GetNPCByID(ID.npc.QM_IXAERN_MNK)
    if math.random(0, 1) == 1 then
        qm:setPos(380, 0, 540, 0) -- G-7
    else
        qm:setPos(460, 0, 540, 0) -- I-7
    end

    qm:updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
