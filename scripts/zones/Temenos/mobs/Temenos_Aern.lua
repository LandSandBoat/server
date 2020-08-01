-----------------------------------
-- Area: Temenos
--  Mob: Temenos Aern
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/zone")
mixins =
{
    require("scripts/mixins/families/aern"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Temenos/IDs")

function onMobDeath(mob, player, isKiller)
    if isKiller then
        mob:setLocalVar("killer", player:getID())
    end
end

function onMobDespawn(mob)
    local battlefield = mob:getBattlefield()
    if battlefield then
        local killer = mob:getLocalVar("killer")
        
        switch (mob:getID()): caseof
        {
            [ID.mob.TEMENOS_C_MOB[5]+19] = function()
                tpz.limbus.extendTimeLimit(battlefield, 5, tpz.zone.TEMENOS)
            end,
            [ID.mob.TEMENOS_C_MOB[5]+20] = function()
                tpz.limbus.extendTimeLimit(battlefield, 5, tpz.zone.TEMENOS)
            end,
            [ID.mob.TEMENOS_C_MOB[5]+29] = function()
                tpz.limbus.extendTimeLimit(battlefield, 5, tpz.zone.TEMENOS)
            end,
            [ID.mob.TEMENOS_C_MOB[5]+30] = function()
                tpz.limbus.extendTimeLimit(battlefield, 5, tpz.zone.TEMENOS)
            end,
        }
        local leftAern=0
        local AernList = 
        {
            ID.mob.TEMENOS_C_MOB[5], ID.mob.TEMENOS_C_MOB[5]+1, ID.mob.TEMENOS_C_MOB[5]+2,
            ID.mob.TEMENOS_C_MOB[5]+4, ID.mob.TEMENOS_C_MOB[5]+5, ID.mob.TEMENOS_C_MOB[5]+7,
            ID.mob.TEMENOS_C_MOB[5]+8, ID.mob.TEMENOS_C_MOB[5]+9, ID.mob.TEMENOS_C_MOB[5]+10,
            ID.mob.TEMENOS_C_MOB[5]+11, ID.mob.TEMENOS_C_MOB[5]+12, ID.mob.TEMENOS_C_MOB[5]+13,
            ID.mob.TEMENOS_C_MOB[5]+16, ID.mob.TEMENOS_C_MOB[5]+18, ID.mob.TEMENOS_C_MOB[5]+19,
            ID.mob.TEMENOS_C_MOB[5]+20, ID.mob.TEMENOS_C_MOB[5]+22, ID.mob.TEMENOS_C_MOB[5]+23,
            ID.mob.TEMENOS_C_MOB[5]+24, ID.mob.TEMENOS_C_MOB[5]+25, ID.mob.TEMENOS_C_MOB[5]+26,
            ID.mob.TEMENOS_C_MOB[5]+29, ID.mob.TEMENOS_C_MOB[5]+30, ID.mob.TEMENOS_C_MOB[5]+31,
            ID.mob.TEMENOS_C_MOB[5]+32, ID.mob.TEMENOS_C_MOB[5]+33, ID.mob.TEMENOS_C_MOB[5]+34, 
        }
    
        for n = 1, 27 do
            if GetMobByID(AernList[n]):isSpawned() then
                leftAern = leftAern + 1
                break
            end
        end
    
        if leftAern == 0 and not GetMobByID(ID.mob.TEMENOS_C_MOB[5]+35):isSpawned() then
            local mobX = mob:getXPos()
            local mobY = mob:getYPos()
            local mobZ = mob:getZPos()
            GetMobByID(ID.mob.TEMENOS_C_MOB[5]+35):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mob.TEMENOS_C_MOB[5]+35):setPos(mobX, mobY, mobZ)
            if killer ~= 0 then
                SpawnMob(ID.mob.TEMENOS_C_MOB[5]+35):updateEnmity(GetPlayerByID(killer))
            end
        end
    end
end
