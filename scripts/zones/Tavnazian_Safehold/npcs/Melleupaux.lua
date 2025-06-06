-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Melleupaux
-----------------------------------
local ID = zones[xi.zone.TAVNAZIAN_SAFEHOLD]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { 16450, 2030, }, -- Dagger
        { 16566, 9216, }, -- Longsword
        { 17335,    4, }, -- Rusty Bolt
    }

    if player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.SHELTERING_DOUBT then
        table.insert(stock, { 18375, 37296, }) -- Falx
        table.insert(stock, { 18214, 20762, }) -- Voulge
    end

    player:showText(npc, ID.text.MELLEUPAUX_SHOP_DIALOG) -- 10910 without ch4 complete, may change
    xi.shop.general(player, stock)
end

return entity
