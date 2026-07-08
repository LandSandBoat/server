-----------------------------------
-- Area: Bhaflau Remnants
--  MOB: Empathic Flan
-- Defeating all four in AnimationSub(2) will spawn Dormant Rampart
-- Rampart will spawn in the room that the last Flan is killed in
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    local mobID = mob:getID()

    if mobID == ID.mob.EMPATHIC_FLAN[1] or mobID == ID.mob.EMPATHIC_FLAN[3] then
        mob:setMod(xi.mod.UDMGMAGIC, 2125)
        mob:setMod(xi.mod.UDMGPHYS, -50)
        mob:setMod(xi.mod.UDMGRANGE, -50)
    else
        mob:setMod(xi.mod.UDMGMAGIC, -125)
        mob:setMod(xi.mod.UDMGPHYS, 50)
        mob:setMod(xi.mod.UDMGRANGE, 50)
    end

    -- mob will not shift until 10% damage has been done
    -- validate majority dmg takes it to next phase at 89
    mob:addListener('TAKE_DAMAGE', 'FLAN_TAKE_DAMAGE', function(mobArg, damage, attacker, attackType, damageType)
        if mobArg:getHP() > 0 then
            local accumulatedP = 0
            local accumulatedM = 0
            local firstShift = mobArg:getLocalVar('firstShift')
            if
                attackType == xi.attackType.PHYSICAL or
                attackType == xi.attackType.RANGED
            then
                accumulatedP = mobArg:getLocalVar('physical')
                accumulatedP = accumulatedP + damage
                mobArg:setLocalVar('physical', accumulatedP)
            else
                if
                    mobArg:getAnimationSub() == 1 or
                    (firstShift > 0 and mob:getAnimationSub() == 0)
                then
                    accumulatedM = mobArg:getLocalVar('magical2')
                    accumulatedM = accumulatedM + damage
                    mobArg:setLocalVar('magical2', accumulatedM)
                else
                    accumulatedM = mobArg:getLocalVar('magical')
                    accumulatedM = accumulatedM + damage
                    mobArg:setLocalVar('magical', accumulatedM)
                end
            end

            if mobArg:getHPP() < 90 and firstShift == 0 then
                if mobArg:getLocalVar('physical') > mobArg:getLocalVar('magical') + mobArg:getMaxHP() * 0.1 then
                    mobArg:setLocalVar('firstShift', 1)
                    mobArg:setAnimationSub(2) -- Spike head
                    mobArg:setMod(xi.mod.UDMGPHYS, -75)
                    mobArg:setMod(xi.mod.UDMGRANGE, -75)
                    mobArg:setMod(xi.mod.UDMGMAGIC, 2900)
                    mobArg:setLocalVar('magical', 0)
                elseif mobArg:getLocalVar('magical') > mobArg:getLocalVar('physical') + mobArg:getMaxHP() * 0.1 then
                    mobArg:setLocalVar('firstShift', 1)
                    mobArg:setAnimationSub(1)
                    mobArg:setMod(xi.mod.UDMGPHYS, -25)
                    mobArg:setMod(xi.mod.UDMGRANGE, -25)
                    mobArg:setMod(xi.mod.UDMGMAGIC, 562)
                    mobArg:setLocalVar('physical', 0)
                end
            elseif mobArg:getAnimationSub() == 2 and firstShift > 0 then
                local threshold = mobArg:getLocalVar('physical') * 0.75
                if mobArg:getLocalVar('magical') > threshold then
                    mobArg:setAnimationSub(0)
                    mobArg:setMod(xi.mod.UDMGPHYS, -50)
                    mobArg:setMod(xi.mod.UDMGRANGE, -50)
                    mobArg:setMod(xi.mod.UDMGMAGIC, 2125)
                    mobArg:setLocalVar('physical', 0)
                end
            elseif mobArg:getAnimationSub() == 0 and firstShift > 0 then
                local threshold = (mobArg:getLocalVar('magical') + mobArg:getLocalVar('magical2')) * 0.75
                if
                    mobArg:getLocalVar('physical') > threshold and
                    (attackType == xi.attackType.PHYSICAL or attackType == xi.attackType.RANGED)
                then
                    mobArg:setAnimationSub(2)
                    mobArg:setMod(xi.mod.UDMGPHYS, -75)
                    mobArg:setMod(xi.mod.UDMGRANGE, -75)
                    mobArg:setMod(xi.mod.UDMGMAGIC, 2900)
                    mobArg:setLocalVar('magical', 0)
                    mobArg:setLocalVar('magical2', 0)
                elseif
                    mobArg:getLocalVar('magical2') > 250 and
                    attackType ~= xi.attackType.PHYSICAL and
                    attackType ~= xi.attackType.RANGED
                then
                    mobArg:setAnimationSub(1)
                    mobArg:setMod(xi.mod.UDMGPHYS, -25)
                    mobArg:setMod(xi.mod.UDMGRANGE, -25)
                    mobArg:setMod(xi.mod.UDMGMAGIC, 562)
                end
            elseif mobArg:getAnimationSub() == 1 and firstShift > 0 then
                local threshold = mobArg:getLocalVar('magical2') * 0.8
                if mobArg:getLocalVar('physical') > threshold then
                    mobArg:setAnimationSub(0)
                    mobArg:setMod(xi.mod.UDMGPHYS, -50)
                    mobArg:setMod(xi.mod.UDMGRANGE, -50)
                    mobArg:setMod(xi.mod.UDMGMAGIC, 2125)
                    mobArg:setLocalVar('magical2', 0)
                end
            end
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()
        if instance then
            local dormant = GetNPCByID(ID.npc.DORMANT_RAMPART[2], instance)
            if dormant then
                local spawn = dormant:getLocalVar('spawn')

                if mob:getAnimationSub() == 2 then
                    dormant:setLocalVar('spawn', spawn + 1)
                    if dormant:getLocalVar('spawn') == 4 then
                        local offset = 1 + ID.mob.EMPATHIC_FLAN[1] - mob:getID()
                        local points =
                        {
                            [1] = { 315, -4, 260, 128 },
                            [2] = { 340, -4, 235,  60 },
                            [3] = { 365, -4, 260,   0 },
                            [4] = { 340, -4, 285, 194 },
                        }

                        dormant:setPos(points[offset])
                        instance:setLocalVar('dormantArea', offset)
                        dormant:setStatus(xi.status.NORMAL)
                        dormant:setUntargetable(false)
                    end
                end
            end

            xi.salvage.spawnTempChest(mob)
        end
    end
end

return entity
