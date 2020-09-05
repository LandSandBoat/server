-----------------------------------
-- Area: Grand Palace of HuXzoi
--  Mob: Ix'aern MNK
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    -- adjust drops based on number of HQ Aern Organs traded to QM
    local qm = GetNPCByID(ID.npc.IXAERN_MNK_QM)
    local chance = qm:getLocalVar("[SEA]IxAern_DropRate")
    if (math.random(0, 1) > 0) then
        SetDropRate(4398, 1851, chance * 10) -- Deed Of Placidity
        SetDropRate(4398, 1901, 0)
    else
        SetDropRate(4398, 1851, 0)
        SetDropRate(4398, 1901, chance * 10) -- Vice of Antipathy
    end
    qm:setLocalVar("[SEA]IxAern_DropRate", 0)

    mob:AnimationSub(1) -- Reset the subanim - otherwise it will respawn with bracers on. Note that Aerns are never actually supposed to be in subanim 0.
end

function onMobFight(mob, target)
    -- The mob gains a huge boost when it 2hours to attack speed and attack.
    -- It forces the minions to 2hour as well. Wiki says 50% but all videos show 60%.
    if (mob:getLocalVar("BracerMode") == 0) then
        if (mob:getHPP() < math.random(50, 60)) then
            -- Go into bracer mode
            mob:setLocalVar("BracerMode", 1)
            mob:AnimationSub(2)
            mob:addMod(tpz.mod.ATT, 200)
            mob:addMod(tpz.mod.HASTE_ABILITY, 1500)
            mob:useMobAbility(3411) -- Hundred Fists

            -- Force minions to 2hour
            for i = 1, 2 do
                local minion = GetMobByID(mob:getID() + i)
                if (minion:getCurrentAction() ~= tpz.act.NONE) then
                    minion:useMobAbility(3411 + i) -- Chainspell or Benediction
                end
            end
        end
    end
end

function onMobDeath(mob, player, isKiller)
    DespawnMob(mob:getID()+1)
    DespawnMob(mob:getID()+2)
end

function onMobDespawn(mob)
    DespawnMob(mob:getID()+1)
    DespawnMob(mob:getID()+2)

    local qm = GetNPCByID(ID.npc.IXAERN_MNK_QM)
    if (math.random(0, 1) == 1) then
        qm:setPos(380, 0, 540, 0) -- G-7
    else
        qm:setPos(460, 0, 540, 0) -- I-7
    end
    qm:updateNPCHideTime(FORCE_SPAWN_QM_RESET_TIME)
end
