exports.UUID = () => {
  let result = "";
  const characters =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  const charactersLength = characters.length;
  for (let i = 0; i < 12; i++) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  return result;
};

const padTo2Digits = (num) => {
  return num.toString().padStart(2, "0");
};

exports.formatDate = (date) => {
  return [
    date.getFullYear(),
    padTo2Digits(date.getMonth() + 1),
    padTo2Digits(date.getDate()),
  ].join("-");
};

exports.dateIsValid = (dateStr) => {
  const regex = /^\d{4}-\d{2}-\d{2}$/;

  let data = dateStr.split("-").reverse().join("-");
  if (data.match(regex) === null) {
    return false;
  }
  const date = new Date(data);

  const timestamp = date.getTime();

  if (typeof timestamp !== "number" || Number.isNaN(timestamp)) {
    return false;
  }

  return date.toISOString().startsWith(data);
};

exports.formValidation = (data) => {
  let error = {};
  let { name, email, phone, dob, password } = data;
  if (!phone) {
    error = "phone number is missing ";
  } else if (
    !/^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/.test(parseInt(phone))
  ) {
    error = "phone number is invalid";
  } else if (!name) {
    error = "name is missing ";
  } else if (!email) {
    error = "Email id is missing";
  } else if (!/\S+@\S+\.\S+/.test(email)) {
    error = "Email address is invalid";
  } else if (!password) {
    error = "Password is missing";
  } else if (password?.length < 6) {
    error = "Password must be 6 or more characters";
  } else if (!dob) {
    error = "birthday is missing";
  } else if (new Date(dob)) {
    error = "birthday is invalide";
  }
  console.log(error);
  return error;
};
