export function deleteIdStr (lists) {
  let i
  for (i of lists) { delete i.id_str }
  return lists
}
