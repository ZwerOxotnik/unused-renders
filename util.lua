local util = {}


--[[
util.correct_file_path(path: string|data.FileName): string|data.FileName
util.get_image_as_sprite(path: string|data.FileName, scale: double?, data: table|data.Sprite?): data.Sprite
util.get_icon_size(path: string|data.FileName): integer
util.set_icon_data(data.PrototypeBase|table, path: string|data.FileName)
]]--


---@param path string|data.FileName
---@return string|data.FileName
function util.correct_file_path(path)
    if not path:find("^__") then
        path = "__unused-renders-m__/" .. path
    end

    return path
end


---@param path string|data.FileName
---@return integer
function util.get_icon_size(path)
    local filename = path:match("^(.+)%.[Pp][Nn][Gg]$") or path
    return require(filename).height
end


---@param path string|data.FileName
---@param scale double?
---@param data table|data.Sprite?
---@return data.Sprite
function util.get_image_as_sprite(path, scale, data)
    ---@type data.Sprite
    data = data or {}

    data.filename = util.correct_file_path(path)
    data.size  = util.get_icon_size(data.filename)
    data.scale = scale

    if path:find("mipped") then
        data.mipmap_count = 4
    end

    return data
end


---@param prototype data.PrototypeBase|table
---@param path string|data.FileName
function util.set_icon_data(prototype, path)
    path = util.correct_file_path(path)

    prototype.icon_size = util.get_icon_size(path)
    prototype.icon = path
end


return util