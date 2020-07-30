-----------------------------------
--
-- Zone: Temenos (37)
--
-----------------------------------
local ID = require("scripts/zones/Temenos/IDs")
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/limbus")
-----------------------------------

-----------------------------------
-- onInitialize
-----------------------------------

function onInitialize(zone)
    SetServerVariable("[Temenos_W_Tower]UniqueID", 0)
    SetServerVariable("[Temenos_N_Tower]UniqueID", 0)
    SetServerVariable("[Temenos_E_Tower]UniqueID", 0)
    SetServerVariable("[C_Temenos_Base]UniqueID", 0)
    SetServerVariable("[C_Temenos_Base_II]UniqueID", 0)
    SetServerVariable("[C_Temenos_1st]UniqueID", 0)
    SetServerVariable("[C_Temenos_2nd]UniqueID", 0)
    SetServerVariable("[C_Temenos_3rd]UniqueID", 0)
    SetServerVariable("[C_Temenos_4th]UniqueID", 0)
    SetServerVariable("[C_Temenos_4th_II]UniqueID", 0)

    zone:registerRegion(1,  378, 70, -186    , 382, 72, -182) -- 'Temenos_Western_Tower'    380 71 -184
    zone:registerRegion(2,  378, 70, 373    , 382, 72, 377) -- 'Temenos_Northern_Tower'   380 71 375
    zone:registerRegion(3,  378, -4, 93    , 382, 4, 98) -- 'Temenos_Eastern_Tower'    380 -2 96
    zone:registerRegion(4,  578, -4, -546    , 582, 4, -542) -- 'Central_Temenos_Basement' 580 -2 -544
    zone:registerRegion(5,  258, -164, -506    , 262, -160, -502) -- 'Central_Temenos_1st_Floor' 260 -162 -504
    zone:registerRegion(6,  18, -4, -546    , 22, 4, -542) -- 'Central_Temenos_2nd_Floor' 20 -2 -544
    zone:registerRegion(7,  -298, -164, -502    , -294, -160, -498) -- 'Central_Temenos_3rd_Floor' -296 -162 -500
    zone:registerRegion(8,  -542, -4, -586    , -538, 4, -582) -- 'Central_Temenos_4th_Floor'  -540 -2  -584
end


-----------------------------------
-- onConquestUpdate
-----------------------------------

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

-----------------------------------
-- onZoneIn
-----------------------------------

function onZoneIn(player, prevZone)
    local cs = -1
        player:setPos(580, -1.5, 4.452, 192)
    return cs
end

-----------------------------------
-- onRegionEnter
-----------------------------------

function onRegionEnter(player, region)
    local regionID = region:GetRegionID()

    switch (regionID): caseof
    {
        [1] = function (x)
            if (player:hasStatusEffect(tpz.effect.BATTLEFIELD) == false) then
                -- create instance   Temenos_Western_Tower
                RegisterLimbusInstance(player, 1298)
            end
        end,
        [2] = function (x)
            if (player:hasStatusEffect(tpz.effect.BATTLEFIELD) == false) then
                -- create instance Temenos_Northern_Tower
                RegisterLimbusInstance(player, 1299)
            end
        end,
        [3] = function (x)
            if (player:hasStatusEffect(tpz.effect.BATTLEFIELD) == false) then
                -- create instance Temenos_Eastern_Tower
                RegisterLimbusInstance(player, 1300)
            end
        end,
        [4] = function (x)
            if (player:hasStatusEffect(tpz.effect.BATTLEFIELD) == false) then
                -- create instance  Central_Temenos_Basement
                RegisterLimbusInstance(player, 1301)
            end
        end,
        [5] = function (x)
            if (player:hasStatusEffect(tpz.effect.BATTLEFIELD) == false) then
                -- create instance Central_Temenos_1st_Floor
                RegisterLimbusInstance(player, 1303)
            end
        end,
        [6] = function (x)
            if (player:hasStatusEffect(tpz.effect.BATTLEFIELD) == false) then
                -- create instance   Central_Temenos_2nd_Floor
                RegisterLimbusInstance(player, 1304)
            end
        end,
        [7] = function (x)
            if (player:hasStatusEffect(tpz.effect.BATTLEFIELD) == false) then
                -- create instance Central_Temenos_3rd_Floor
                RegisterLimbusInstance(player, 1305)
            end
        end,
        [8] = function (x)
            if (player:hasStatusEffect(tpz.effect.BATTLEFIELD) == false) then
                -- create instance Central_Temenos_4th_Floor
                RegisterLimbusInstance(player, 1306)
            end
        end,
    }
end


function onRegionLeave(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
