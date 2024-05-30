require('gen').setup({
  model = 'llama3',
  host = 'localhost',
  port = '11434',
  display_mode = 'float',
  show_prompt = false,
  show_model = false,
  debug = false,
})

require('gen').prompts = {
  Generate = { prompt = "$input", replace = true },
  Summarize = { prompt = "Summarize the following text:\n$text" },
  Ask = { prompt = "Regarding the following text, $input:\n$text" },
  Enhance_Grammar_Spelling = {
    prompt = "Modify the following text to improve grammar and spelling, just output the final text without additional quotes around it:\n$text",
    replace = true,
  },
  Enhance_Wording = {
    prompt = "Modify the following text to use better wording, just output the final text without additional quotes around it:\n$text",
    replace = true,
  },
  Enhance_Code = {
    prompt = "Enhance the following code, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
    replace = true,
    extract = "```$filetype\n(.-)```",
  }
}
