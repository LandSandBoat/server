-----------------------------------
-- Bugle Call
-- Description: Calls help from additional Imp Bandsman and grants TP
-- Used only by the main Imp Bandsman in Call to Arms ISNM
-----------------------------------
local ID = zones[xi.zone.TALACCA_COVE]
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Only allow the main Imp Bandsman to use this which has the level range of 63-64
    if mob:getMainLvl() >= 63 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local mobID = mob:getID()
    local player = mob:getTarget()

    skill:setMsg(xi.msg.basic.NONE)

    mob:timer(4000, function(mobArg)
        mobArg:addTP(1000)
    end)

    mob:timer(3000, function(mobArg)
        for cloneID = mobID + 1, mobID + 4 do
            local clone = GetMobByID(cloneID)
            if clone and not clone:isSpawned() then
                SpawnMob(cloneID)
                if player then
                    clone:updateEnmity(player)
                end

                mobArg:messageText(mobArg, ID.text.HELP_HAS_ARRIVED, false)
                return
            end
        end

        mobArg:messageText(mobArg, ID.text.NOBODY_COMES_TO_HELP, false)
    end)

    return 0
end

return mobskillObject
