local function base64_decode (data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/' -- You will need this for encoding/decoding
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
    end))
end

function ParseJwt()
    local jwt_token = vim.api.nvim_get_current_line()

    local parts = vim.split(jwt_token, '%.')

    if #parts == 3 then
        local payload = parts[2]

        payload = payload:gsub('-', '+'):gsub('_', '/')
        local rem = #payload % 4
        if rem > 0 then
            payload = payload .. string.rep('=', 4 - rem)
        end
        local decoded = vim.fn.json_decode(base64_decode(payload))

        local output = vim.inspect(decoded)
        -- The nvim_buf_set_lines does not work with new lines in a buffer. 
        local lines = vim.split(output, '\n')
        vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    else
        vim.api.nvim_err_write('Invalid JWT format\n')
    end
end

vim.api.nvim_set_keymap('n', '<leader>wd', ":lua ParseJwt()<CR>", { noremap = true, silent = true })
