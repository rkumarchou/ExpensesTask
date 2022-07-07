export const serializeErrorMessage = (error) => {
  const message = error.message || "There is some error in connecting with server!"
  console.log(error)
  return message;
};
