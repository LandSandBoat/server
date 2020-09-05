-----------------------------------------
-- ID: 6379
-- Item: Ornate Stool
-- Item Effect: Grant Ornate stool key item
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/msg")

local keyItemId = tpz.ki.ORNATE_STOOL

function onItemCheck(target)
    if target:hasKeyItem(keyItemId) then
        return tpz.msg.basic.ALREADY_HAVE_KEY_ITEM, 0, keyItemId
    end
    return 0
end

function onItemUse(target)
    target:addKeyItem(keyItemId)
    target:messageBasic(tpz.msg.basic.OBTAINED_KEY_ITEM, 6379, keyItemId)
end
