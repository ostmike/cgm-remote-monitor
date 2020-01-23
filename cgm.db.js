db.createUser(
  {
    user: "cgm",
    pwd: "cgm",
    roles: [
      {
        role: "readWrite",
        db: "cgm"
      }
    ]
  }
);
