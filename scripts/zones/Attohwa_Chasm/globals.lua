-----------------------------------
-- Zone: Attohwa_Chasm
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
-----------------------------------

local attohwaChasmGlobal =
{
    -- Check to see if any mobs associated with Feeler Antlion are still spawned
    -- if not then can start the timer to respawn the ???; a custom function is needed
    -- because npcUtil.popFromQM does not support ??? timer when mobs pop other mobs
    canStartFeelerQMTimer = function(despawningMobID)
        -- assume true that none of the mobs are spawned
        local canStartTimer = true

        -- first check feeler and alastor to make sure not spawned
        local feeler = GetMobByID(ID.mob.FEELER_ANTLION)
        local alastor = GetMobByID(ID.mob.ALASTOR_ANTLION)
        if (feeler and feeler:isSpawned()) or (alastor and alastor:isSpawned()) then
            canStartTimer = false
        end

        -- then check all executioners to make sure not spawned
        for _, executionerID in ipairs(ID.mob.EXECUTIONER_ANTLION) do
            local executioner = GetMobByID(executionerID)
            if executioner and executioner:isSpawned() then
                canStartTimer = false
                break
            end
        end

        return canStartTimer
    end,

    handleMiasma = function(npc)
        local timer    = npc:getLocalVar('timer')
        local newTimer = math.random(30, 40)

        if GetSystemTime() >= timer then
            if npc:getAnimation() == xi.anim.CLOSE_DOOR then
                npc:setAnimation(xi.anim.OPEN_DOOR)
            else
                npc:setAnimation(xi.anim.CLOSE_DOOR)
            end

            npc:setLocalVar('timer', GetSystemTime() + newTimer)
        end
    end
}

return attohwaChasmGlobal
